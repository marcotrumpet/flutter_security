/// [ResponseSecurityCodes] Available errors.
///
/// [tampered] used when current package signature doesn't match with the one you think should be (both iOs and Android)
///
/// [notTampered] used when current package signature does match with the one you think should be (both iOs and Android)
///
/// [genericError] simple generic error
///
/// [unavailable] if you ask for a specific method and it's not available (maybe for the specific platform, like [FlutterSecurity.hasBundleBeenCompromised()] that isn't available on Android)
///
/// [missingParametersError] when you ask for a method that needs a parameter and it cant find it
enum ResponseSecurityCodes {
  tampered,
  notTampered,
  genericError,
  unavailable,
  missingParametersError,
}
