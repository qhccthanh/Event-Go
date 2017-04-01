//
//  LaunchScreenViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import enum Result.NoError
import GoogleSignIn
class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var avatarAppView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        if #available(iOS 10.0, *) {
//            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
//                UIView.animate(withDuration: 11.0, animations: {
//                    self.avatarAppView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
//                })
//            }
//        } else {
//            // Fallback on earlier versions
//        }
        
//        rotateView(targetView: avatarAppView, duration: 5)
        
        self.avatarAppView.rotate360Degrees()
//        Timer.scheduledTimer(timeInterval: 50, target: self, selector: #selector(self.stopRotateView), userInfo: nil , repeats: false)
    }

    @IBAction func loginFBAction(_ sender: Any) {
        
        let loginFacebookSignal = EVAuthenticationManager.share().authenticateWithFacebook(in: self)
        loginFacebookSignal?.subscribeNext({ (response) in
            
            let token = FBSDKAccessToken.current().tokenString
            var loginServerSignal = EVUserServices.shareInstance.login(with: token!)
            
            loginServerSignal.subscribeNext({ (result) in
                self.stopRotateView()
            })
            
        }, error: { (error) in
            
        })
    }
    
    @IBAction func loginGoogleAction(_ sender: Any) {
        
        let loginGoogleSignal = EVAuthenticationManager.share().authenticateWithGoogle(in: self)
        loginGoogleSignal?.subscribeNext({ (response) in
            print(response ?? nil)
//            let user = response! GIDGoogleUser
        }, error: { (error) in
            print(error ?? nil)
        })
        
    }
    
    func stopRotateView(){
        self.avatarAppView.layer.removeAllAnimations()
        if let tvc = UIStoryboard(name: "DemoST", bundle: nil).instantiateViewController(withIdentifier: "EVMainGameController") as? EVMainGameController {
            self.present(tvc, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 5) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
