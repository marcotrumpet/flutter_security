import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:flutter_security/helpers/json_object.dart';
import 'package:flutter_security/helpers/platform_errors.dart';
import 'package:flutter_security/helpers/platform_options.dart';
import 'package:flutter_security/helpers/response_codes.dart';

class FlutterSecurity {
  static const MethodChannel _channel = const MethodChannel('flutter_security');

  /// Returns an `ResponseSecurityCodes` enum.
  /// Takes `iosSecurityOptions` and `androidSecurityOptions` as parameters
  static Future<ResponseSecurityCodes> amITampered({
    required IosSecurityOptions? iosSecurityOptions,
    required AndroidSecurityOptions? androidSecurityOptions,
  }) async {
    late ResponseSecurityCodes result;
    late Map<String, dynamic> arguments;

    if (androidSecurityOptions == null || iosSecurityOptions == null) {
      return ResponseSecurityCodes.missingParametersError;
    }

    if (Platform.isIOS) {
      arguments = iosSecurityOptions.toJson();
    } else {
      arguments = androidSecurityOptions.toJson();
    }

    try {
      final String? tamperedResults = await _channel.invokeMethod(
        'amITampered',
        arguments,
      );
      result = PlatformResponseCodes.fromString(tamperedResults);
      return result;
    } on PlatformException catch (e) {
      result = PlatformResponseCodes.fromString(e.code);
      return result;
    }
  }

  /// [hasBundleBeenCompromised] returns true if MD5 contained in the encryptd source file doesn't match with the one calculated at runtime
  ///
  /// iOs only
  ///
  /// First you need to use the script you can find [here](https://github.com/ziomarco/mobile-security-hashgenerator) to generate an encrypted Map<String, String>
  /// like in [JsonObject], then use [jsonFileName] to pass the file name
  static Future<bool?> hasBundleBeenCompromised({
    required IosSecurityOptions? iosSecurityOptions,
  }) async {
    late Map<String, dynamic> arguments;

    if (Platform.isIOS) {
      try {
        if (iosSecurityOptions?.bundleId == null ||
            iosSecurityOptions?.jsonFileName == null ||
            iosSecurityOptions?.cryptographicKey == null)
          throw ResponseSecurityCodes.missingParametersError;

        arguments = iosSecurityOptions!.toJson();

        final decryptedObject = await _getDecriptedObject(
            arguments: arguments, iosSecurityOptions: iosSecurityOptions);

        if (decryptedObject == null) return null;
        final nativeJsonObject = await _getNativeJsonObject(
            decriptedObject: decryptedObject,
            iosSecurityOptions: iosSecurityOptions);

        return await _areMD5different(
          decryptedObject: decryptedObject,
          nativeJsonObject: nativeJsonObject,
        );
      } on PlatformException catch (e) {
        throw PlatformResponseCodes.fromString(e.code);
      }
    }
    throw ResponseSecurityCodes.unavailable;
  }

  static Future<bool> _areMD5different({
    required List<JsonObject> decryptedObject,
    required List<JsonObject> nativeJsonObject,
  }) async {
    JsonObject? different;
    final time = DateTime.now();
    for (var e in decryptedObject) {
      if (different != null) break;

      try {
        different = nativeJsonObject.firstWhere((element) {
          if (element.path == e.path) {
            if (element.hash != e.hash) {
              return true;
            }
          }
          return false;
        });
      } on StateError catch (_) {}
    }
    print(
        'Total for loop done in ${DateTime.now().difference(time).inMilliseconds}ms');
    if (different != null) {
      return true;
    }
    return false;
  }

  static Future<List<JsonObject>?> _getDecriptedObject({
    required IosSecurityOptions? iosSecurityOptions,
    required Map<String, dynamic> arguments,
  }) async {
    final time = DateTime.now();
    final cryptedJsonPath = await _getCriptedJsonPath(arguments);

    final keyString = iosSecurityOptions!.cryptographicKey!;

    final file = File(cryptedJsonPath!).readAsBytesSync();

    final key = Key.fromUtf8(keyString);
    final iv = IV(file.sublist(0, 16));

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

    final encrypted = Encrypted(file.sublist(16));

    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    final decryptedFileAsString = String.fromCharCodes(decrypted.codeUnits);

    final decodedObject = json.decode(decryptedFileAsString) as List<dynamic>;

    final jsonObject =
        decodedObject.map((e) => JsonObject.fromJson(e)).toList();

    print(
        'Total decryption done in ${DateTime.now().difference(time).inMilliseconds}ms');

    return jsonObject;
  }

  static Future<List<JsonObject>> _getNativeJsonObject({
    required IosSecurityOptions? iosSecurityOptions,
    required List<JsonObject>? decriptedObject,
  }) async {
    final time = DateTime.now();
    final updatedIosSecurityOptions = iosSecurityOptions!.copyWith(
      listOfPaths: decriptedObject?.map((e) => e.path).toList(),
    );

    final updatedArguments = updatedIosSecurityOptions.toJson();

    final jsonResult =
        await _channel.invokeMethod('getBundleMD5List', updatedArguments);

    if (jsonResult == null) throw ResponseSecurityCodes.missingParametersError;

    final decodedJsonResult = json.decode(jsonResult) as List<dynamic>;

    final jsonObjectList =
        decodedJsonResult.map((e) => JsonObject.fromJson(e)).toList();
    print(
        'Total native object fetched in ${DateTime.now().difference(time).inMilliseconds}ms');
    return jsonObjectList;
  }

  static Future<String?> _getCriptedJsonPath(
      Map<String, dynamic> arguments) async {
    try {
      final String? path =
          await _channel.invokeMethod('getCriptedJsonPath', arguments);
      return path;
    } on PlatformException catch (e) {
      throw PlatformResponseCodes.fromString(e.code);
    }
  }
}
