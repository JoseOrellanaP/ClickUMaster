import UIKit
import Flutter
import Firebase
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)

    GMSServices.provideAPIKey("AIzaSyChUPVxb5ypfjd7B-wj_xtbdUuXJ5OT2GY")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
