import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto_keys/crypto_keys.dart';
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

  static Future<bool> hasBundleBeenCompromised({
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

        final nativeJsonObject = await _getNativeJsonObject(
            decriptedObject: decryptedObject,
            iosSecurityOptions: iosSecurityOptions);

        return !(await _areMD5matching(
            decryptedObject: decryptedObject,
            nativeJsonObject: nativeJsonObject));
      } on PlatformException catch (e) {
        throw PlatformResponseCodes.fromString(e.code);
      }
    }
    throw ResponseSecurityCodes.unavailable;
  }

  static Future<bool> _areMD5matching({
    required List<JsonObject>? decryptedObject,
    required List<JsonObject> nativeJsonObject,
  }) async {
    final matchedList = decryptedObject?.where(
        (e) => nativeJsonObject.contains((element) => element.path == e.path));

    return matchedList?.length == decryptedObject?.length;
  }

  static Future<List<JsonObject>?> _getDecriptedObject({
    required IosSecurityOptions? iosSecurityOptions,
    required Map<String, dynamic> arguments,
  }) async {
    final cryptedJsonPath = await _getCriptedJsonPath(arguments);

    final keyString = iosSecurityOptions!.cryptographicKey!;

    final file = File(cryptedJsonPath!).readAsBytesSync();

    var keyPair = KeyPair.symmetric(
        SymmetricKey(keyValue: Uint8List.fromList(keyString.codeUnits)));

    var decrypter =
        keyPair.privateKey!.createEncrypter(algorithms.encryption.aes.gcm);

    var decrypted = decrypter.decrypt(
      EncryptionResult(
        Uint8List.fromList(file.skip(12).toList()),
        initializationVector: Uint8List.fromList(file.getRange(0, 12).toList()),
      ),
    );

    final decryptedFileAsString = String.fromCharCodes(decrypted);
    final decodedObject = json.decode(decryptedFileAsString) as List<dynamic>;

    final jsonObject =
        decodedObject.map((e) => JsonObject.fromJson(e)).toList();

    return jsonObject;
  }

  static Future<List<JsonObject>> _getNativeJsonObject({
    required IosSecurityOptions? iosSecurityOptions,
    required List<JsonObject>? decriptedObject,
  }) async {
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
