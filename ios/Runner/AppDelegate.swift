import UIKit
import Flutter
import Firebase
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    private var containerView: UIView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyCqmMDevuy1ODsGZP15SfDTUFeWdx2-2to")
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)

  }
    

    override func applicationWillResignActive(_ application: UIApplication) {
          containerView = UIView(frame: window.bounds)
          guard let view = containerView else { return }
        view.backgroundColor = UIColor.white
          window.addSubview(view)
          
      }
      
      override func applicationDidBecomeActive(_ application: UIApplication) {
          guard let view = containerView else {return }
          view.removeFromSuperview()

    
      }
    
    
//    extension UIWindow {
//        func makeSecure() {
//            DispatchQueue.main.async {
//                let field = UITextField()
//                field.isSecureTextEntry = true
//                self.addSubview(field)
//                field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//                field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//                self.layer.superlayer?.addSublayer(field.layer)
//                field.layer.sublayers?.first?.addSublayer(self.layer)
//            }
//        }
//    }
  
}
