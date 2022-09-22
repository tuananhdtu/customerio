import Flutter
import UIKit
import CioTracking

public class SwiftCustomerioPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "customerio", binaryMessenger: registrar.messenger())
    let instance = SwiftCustomerioPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
      case "initCustomerIO":
          let jsonString =  call.arguments as! String
          let data = jsonString.data(using: .utf8)!

          let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
          let siteId = json["siteId"]
          let apiKey = json["apiKey"]
          

          let customerIO = CustomerIO(siteId: siteId, apiKey: apiKey, region: Region.EU)
          break;
      default:
          break;
      }
  }
}
