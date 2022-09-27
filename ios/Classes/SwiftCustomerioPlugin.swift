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
          
          UNUserNotificationCenter.current().delegate = self
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
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")

        // Customer.io push notifications include data regarding the push
        // message in the data part of the payload which can be used to send
        // feedback into our system.
        var deliveryID: String = "";
        if let value = data["CIO-Delivery-ID"] {
            deliveryID = String(describing: value)
        }
        var deliveryToken: String = "";
        if let value = data["CIO-Delivery-Token"] {
            deliveryToken = String(describing: value)
        }
        MessagingPush.shared.trackMetric(deliveryID: deliveryID, event: .delivered, deviceToken: deliveryToken)

    }
}
    

extension SwiftCustomerioPlugin: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(
     _ center: UNUserNotificationCenter,
     didReceive response: UNNotificationResponse,
     withCompletionHandler completionHandler: @escaping () -> Void
 ) {
     let handled = MessagingPush.shared.userNotificationCenter(center, didReceive: response,
                                                              withCompletionHandler: completionHandler)
     // If the Customer.io SDK does not handle the push, it's up to you to handle it and call the
     // completion handler. If the SDK did handle it, it called the completion handler for you.
     if !handled {
         completionHandler()
     }
 }
    
    // OPTIONAL: If you want your push UI to show even with the app in the foreground, override this function and call
    // the completion handler.
    @available(iOS 10.0, *)
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        if #available(iOS 14.0, *) {
            completionHandler([.list, .banner, .badge, .sound])
        } else {
            // Fallback on earlier versions
        }
    }
}
