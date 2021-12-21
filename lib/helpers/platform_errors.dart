import 'package:flutter_security/helpers/response_codes.dart';

/// Returns the [ResponseSecurityCodes] enum corresponding to the evaluated string
class PlatformResponseCodes {
  static ResponseSecurityCodes fromString(String? s) {
    switch (s) {
      case 'tampered':
        return ResponseSecurityCodes.tampered;
      case 'notTampered':
        return ResponseSecurityCodes.notTampered;
      case 'missingParametersError':
        return ResponseSecurityCodes.missingParametersError;
      case 'unavailable':
        return ResponseSecurityCodes.unavailable;
      case 'genericError':
      default:
        return ResponseSecurityCodes.genericError;
    }
  }
}
