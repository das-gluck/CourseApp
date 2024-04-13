import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// import SwiftUI
// import FirebaseCore
//
//
// class AppDelegate: NSObject, UIApplicationDelegate {
//   func application(_ application: UIApplication,
//                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//     FirebaseApp.configure()
//
//     return true
//   }
// }
//
// @main
// struct YourApp: App {
//   // register app delegate for Firebase setup
//   @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//
//   var body: some Scene {
//     WindowGroup {
//       NavigationView {
//         ContentView()
//       }
//     }
//   }
// }


