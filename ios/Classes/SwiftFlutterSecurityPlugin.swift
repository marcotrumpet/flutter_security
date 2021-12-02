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
        switch call.method {
        case "amITampered":
            amITampered(call: call, result: result)
        case "getBundleMD5List":
            getBundleMD5List(call: call, result: result)
        case "getCriptedJsonPath":
            getCriptedJsonPath(call: call, result: result)
        default:
            result(FlutterError(code: "genericError", message: "Generic Error", details: nil))
        }
    }

    private func getCriptedJsonPath(call: FlutterMethodCall, result: FlutterResult) {
        if let args = call.arguments as? [String: Any], let bundleId = args["bundleId"] as? String, let jsonFileName = args["jsonFileName"] as? String {
            if let bundle = Bundle(identifier: bundleId), let path = bundle.resourcePath {
                let completeJsonPath = path + "/" + jsonFileName
                result(completeJsonPath)
            }
            result(FlutterError(code: "genericError", message: "Generic Error", details: nil))
        }
    }

    private func getBundleMD5List(call: FlutterMethodCall, result: FlutterResult) {
        if let args = call.arguments as? [String: Any], let bundleId = args["bundleId"] as? String, let listOfPaths = args["listOfPaths"] as? [String] {
            if let bundle = Bundle(identifier: bundleId) {
                do {
                    var list: [[String: String]] = []

                    for path in listOfPaths {
                        if #available(iOS 13.0, *) {
                            let md5 = getMD5(string: bundle.resourcePath! + "/" + path)
                            let temp = JsonField(path: path, hash: md5)

                            list.append(temp.asDictionary)

                        } else {
                            result(FlutterError(code: "unavailable", message: "Only available from iOs13", details: nil))
                        }
                    }

                    do {
                        let encoder = JSONEncoder()
                        let listToJson = try encoder.encode(list)
                        let listToJsonString = String(data: listToJson, encoding: .utf8)!

                        result(listToJsonString)
                    } catch {
                        print("error:\(error)")
                        result(FlutterError(code: "genericError", message: "Generic Error", details: nil))
                    }
                }
            }
            result(FlutterError(code: "genericError", message: "Generic Error", details: nil))
        } else {
            result(FlutterError(code: "MissingParameters", message: "One or more parameters are missing.", details: nil))
        }
    }

    private func amITampered(call: FlutterMethodCall, result: FlutterResult) {
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
    }
}
