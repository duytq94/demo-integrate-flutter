import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    lazy var flutterEnginePartialScreen = FlutterEngine(name: "flutterEnginePartialScreen")
    lazy var flutterEngineFullScreen = FlutterEngine(name: "flutterEngineFullScreen")
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Pre-warm flutter
        flutterEnginePartialScreen.run(withEntrypoint: "partialScreenEntryPoint");
        flutterEngineFullScreen.run();
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
}
