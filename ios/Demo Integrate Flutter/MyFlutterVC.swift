import UIKit
import Flutter

class MyFlutterVC: FlutterViewController {
    var flutterChannel: FlutterMethodChannel!
    var param: String!
    var screenChose: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flutterChannel = FlutterMethodChannel(name: "com.duytq.demointegrateflutter",binaryMessenger: self.binaryMessenger)
        flutterChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "getBatteryLevel":
                self?.receiveBatteryLevel(result: result)
            case "getParam":
                result(self?.param)
            case "exitFlutter":
                self?.exitFlutter()
            default:
                result(FlutterMethodNotImplemented)
                return
            }
        })
        flutterChannel.invokeMethod("notifyNavToFlutter", arguments: screenChose)
    }
    
    func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(FlutterError(code: "UNAVAILABLE",
                                message: "Battery info unavailable",
                                details: nil))
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
    
    func exitFlutter() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
