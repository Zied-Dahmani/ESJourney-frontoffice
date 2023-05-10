import UIKit
import Flutter
import ARKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Add this code to load the ARResourceGroup and print the image names
        /*if #available(iOS 11.3, *) {
            guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
                fatalError("Failed to load AR reference images.")
            }
            
            for image in referenceImages {
                print("Image name: \(image.name ?? "Unknown")")
            }
        } else {
            print("ARReferenceImage is not available in this iOS version.")
        }*/
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
