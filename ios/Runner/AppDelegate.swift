import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private let channelName = "device_info"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let deviceInfoChannel = FlutterMethodChannel(name: channelName,
                                                 binaryMessenger: controller.binaryMessenger)
    deviceInfoChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "getIMEI":
        result("Not available on iOS")
      case "getSerialNumber":
        result(self.getSerialNumber())
      default:
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getSerialNumber() -> String {
    return UIDevice.current.identifierForVendor!.uuidString
  }
}