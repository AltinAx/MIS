import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyAuEU2XPfbC4rY5GOca8efqbS0bJmYI5uE")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}