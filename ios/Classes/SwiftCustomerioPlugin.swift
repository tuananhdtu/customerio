import Flutter
import UIKit
import CioTracking
import CioMessagingPushAPN


public class SwiftCustomerioPlugin: NSObject, FlutterPlugin, UIApplicationDelegate {
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
          

          _ =  CustomerIO(siteId: siteId as! String, apiKey: apiKey as! String, region: Region.EU)
          
          UIApplication.shared.registerForRemoteNotifications()
          result("OK")
          break;
      case "setIdentifier" :
          let identifier =  call.arguments as! String
          CustomerIO.shared.identify(identifier: identifier)
          result("OK")
          break;
      default:
          break;
      }
  }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        MessagingPush.shared.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    public  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        MessagingPush.shared.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
}

