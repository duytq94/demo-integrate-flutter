import UIKit
import Flutter

class ViewController: UIViewController {
    var flutterEnginePartialScreen: FlutterEngine!
    var flutterEngineFullScreen: FlutterEngine!
    var flutterViewController: FlutterViewController!
    var flutterChannel: FlutterMethodChannel!
    
    @IBOutlet weak var sendButton: UIButton!
    var screenChose: String! = "HOME"
    
    @IBOutlet weak var tfString: UITextField!
    
    @IBAction func onTapSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            screenChose = "HOME"
            break
        case 1:
            screenChose = "DETAIL"
        default:
            break
        }
    }
    
    @IBAction func btnGoFlutter(_ sender: Any) {
        flutterEngineFullScreen = (UIApplication.shared.delegate as! AppDelegate).flutterEngineFullScreen
        let myflutterVC = MyFlutterVC(engine: flutterEngineFullScreen, nibName: nil, bundle: nil)
        myflutterVC.modalPresentationStyle = .fullScreen
        myflutterVC.param = tfString.text
        myflutterVC.screenChose = screenChose
        self.present(myflutterVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addFlutterView()
    }
    
    func addFlutterView()  {
        flutterEnginePartialScreen = (UIApplication.shared.delegate as! AppDelegate).flutterEnginePartialScreen
        let myFlutterView = FlutterViewController(engine: flutterEnginePartialScreen, nibName: nil, bundle: nil)
        addChild(myFlutterView)
        view.addSubview(myFlutterView.view)
        self.didMove(toParent: self)
        myFlutterView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: myFlutterView.view!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: sendButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 10)
        
        let bottom = NSLayoutConstraint(item: myFlutterView.view!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: -10)
        
        let leading = NSLayoutConstraint(item: myFlutterView.view!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 10)
        
        let trailing = NSLayoutConstraint(item: myFlutterView.view!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: -10)
        
        self.view.addConstraints([bottom, leading, trailing, top])
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
