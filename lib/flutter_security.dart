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

    var time = DateTime.now();
    if (Platform.isIOS) {
      try {
        if (iosSecurityOptions?.bundleId == null ||
            iosSecurityOptions?.jsonFileName == null ||
            iosSecurityOptions?.cryptographicKey == null)
          throw ResponseSecurityCodes.missingParametersError;

        arguments = iosSecurityOptions!.toJson();

        final decryptedObject = await _getDecriptedObject(
            arguments: arguments, iosSecurityOptions: iosSecurityOptions);
        print(
            'Get decrypted object done in ${DateTime.now().difference(time).inMilliseconds}ms');
        time = DateTime.now();

        if (decryptedObject == null) return null;
        final nativeJsonObject = await _getNativeJsonObject(
            decryptedObject: decryptedObject,
            iosSecurityOptions: iosSecurityOptions);
        print(
            'Get native object done in ${DateTime.now().difference(time).inMilliseconds}ms');
        time = DateTime.now();

        return _areMD5different(
          decryptedObject: decryptedObject,
          nativeJsonObject: nativeJsonObject,
        );
      } on PlatformException catch (e) {
        throw PlatformResponseCodes.fromString(e.code);
      }
    }
    throw ResponseSecurityCodes.unavailable;
  }

  /// [_areMD5different] compare paths and hashes from two list of objecs:
  /// [decryptedObject] - the one generated after build that you should implement in you CI/CD flow
  /// [nativeJsonObject] - the one picked at runtime from bundle
  static bool _areMD5different({
    required List<JsonObject> decryptedObject,
    required List<JsonObject> nativeJsonObject,
  }) {
    JsonObject? different;
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
    if (different != null) {
      return true;
    }
    return false;
  }

  /// Decrypts the file with path:hash map using the key you provide
  static Future<List<JsonObject>?> _getDecriptedObject({
    required IosSecurityOptions? iosSecurityOptions,
    required Map<String, dynamic> arguments,
  }) async {
    final cryptedJsonPath = await _getCryptedJsonPath(arguments);

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

    return jsonObject;
  }

  /// It gets the bundle based on [bundleId] parameter. Based on the decrypted path, gets the corresponding hashes at runtime.
  static Future<List<JsonObject>> _getNativeJsonObject({
    required IosSecurityOptions? iosSecurityOptions,
    required List<JsonObject>? decryptedObject,
  }) async {
    final updatedIosSecurityOptions = iosSecurityOptions!.copyWith(
      listOfPaths: decryptedObject?.map((e) => e.path).toList(),
    );

    final updatedArguments = updatedIosSecurityOptions.toJson();

    final jsonResult =
        await _channel.invokeMethod('getBundleMD5List', updatedArguments);

    if (jsonResult == null) throw ResponseSecurityCodes.missingParametersError;

    final decodedJsonResult = json.decode(jsonResult) as List<dynamic>;

    final jsonObjectList =
        decodedJsonResult.map((e) => JsonObject.fromJson(e)).toList();
    return jsonObjectList;
  }

  static Future<String?> _getCryptedJsonPath(
      Map<String, dynamic> arguments) async {
    try {
      final String? path =
          await _channel.invokeMethod('getCryptedJsonPath', arguments);
      return path;
    } on PlatformException catch (e) {
      throw PlatformResponseCodes.fromString(e.code);
    }
  }
}
