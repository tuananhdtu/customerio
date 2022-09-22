import Flutter
import UIKit
import CioTracking
import CioMessagingPushFCM
import FirebaseMessaging


public class SwiftCustomerioPlugin: NSObject, FlutterPlugin, MessagingDelegate {
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
          
          Messaging.messaging().delegate = self
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
    
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        MessagingPush.shared.messaging(messaging, didReceiveRegistrationToken: fcmToken)
    }
}

