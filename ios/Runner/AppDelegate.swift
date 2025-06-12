// import UIKit
// import Flutter
//
// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }


import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.window.makeSecure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Prevent screenshots by hiding the window when the app is in the background
  override func applicationWillResignActive(_ application: UIApplication) {
    self.window?.isHidden = true
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    self.window?.isHidden = false
  }
}

// Extension to prevent screen capture
extension UIWindow {
  func makeSecure() {
    let secureField = UITextField()
    secureField.isSecureTextEntry = true
    self.addSubview(secureField)
    secureField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    secureField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.layer.superlayer?.addSublayer(secureField.layer)
    secureField.layer.sublayers?.first?.addSublayer(self.layer)
  }
}
