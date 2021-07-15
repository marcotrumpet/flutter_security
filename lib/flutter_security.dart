import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
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
}
