import UIKit
import Flutter

class ViewController: UIViewController {
    var flutterEngine: FlutterEngine!
    var flutterViewController: FlutterViewController!
        
    @IBOutlet weak var tfString: UITextField!
    
    @IBAction func btnGoFlutter(_ sender: Any) {
        flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController.modalPresentationStyle = .fullScreen
        present(flutterViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        flutterViewController =
            FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        let batteryChannel = FlutterMethodChannel(name: "com.duytq.demointegrateflutter",
                                                  binaryMessenger: flutterViewController.binaryMessenger)
        batteryChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "getBatteryLevel":
                self?.receiveBatteryLevel(result: result)
            case "getParam":
                result(self?.tfString.text)
            case "exitFlutter":
                self?.exitFlutter()
            default:
                result(FlutterMethodNotImplemented)
                return
            }
        })
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
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
