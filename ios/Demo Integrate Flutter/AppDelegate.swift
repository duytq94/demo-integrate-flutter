import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Pre-warm flutter
        flutterEngine.run();
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
}
