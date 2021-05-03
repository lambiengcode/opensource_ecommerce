import UIKit
import Flutter
// import Firebase
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
      }
      GMSServices.provideAPIKey("AIzaSyAURwoHCVzWdOHBMpP9vDsxgvZVB7-spLI")
      GeneratedPluginRegistrant.register(with: self)
      // application.registerForRemoteNotifications()
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}