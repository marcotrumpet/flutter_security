import Flutter
import IOSSecuritySuite
import UIKit

public class SwiftFlutterSecurityPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_security", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterSecurityPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if let args = call.arguments as? [String: Any], let bundleId = args["bundleId"] as? String, let mobileProvision = args["mobileProvision"] as? String {
      if IOSSecuritySuite.amITampered([.bundleID(bundleId),
                                       .mobileProvision(mobileProvision)]).result
      {
        result(String("tampered"))
      } else {
        result(String("notTampered"))
      }
    } else {
      result(FlutterError(code: "MissingParameters", message: "One or more parameters are missing.", details: nil))
    }

    result(FlutterError(code: "genericError", message: "Generic Error", details: nil))
  }
}
