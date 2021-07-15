import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_security/helpers/platform_errors.dart';
import 'package:flutter_security/helpers/response_codes.dart';

class FlutterSecurity {
  static const MethodChannel _channel = const MethodChannel('flutter_security');

  static Future<ResponseSecurityCodes> get amITampered async {
    late ResponseSecurityCodes result;
    try {
      final String? tamperedResults =
          await _channel.invokeMethod('amITampered');
      result = PlatformResponseCodes.fromString(tamperedResults);
      return result;
    } on PlatformException catch (e) {
      result = PlatformResponseCodes.fromString(e.code);
      return result;
    }
  }
}
