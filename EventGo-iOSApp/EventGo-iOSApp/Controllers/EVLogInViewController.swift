//
//  LaunchScreenViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import FBSDKLoginKit

import GoogleSignIn
import SwiftyJSON

class EVLogInViewController: EVViewController {

    @IBOutlet weak var avatarAppView: UIView!
    var userInfo: EVUser?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatarAppView.rotate360Degrees()
    }

    @IBAction func loginFBAction(_ sender: Any) {
        
        let loginFacebookSignal = EVAuthenticationManager.share().authenticateWithFacebook(in: self)
        loginFacebookSignal?.subscribeNext({ (response) in
            
            if let token = FBSDKAccessToken.current().tokenString{
                var params = Dictionary<String, Any>()
                params["provider_type"] = EVConstant.PROVIDER_FACEBOOK
                params["provider_access_token"] = token
                
                let loginServerSignal = EVUserServices.shareInstance.login(with: params)
                loginServerSignal.subscribeNext({ (response) in
                    
                    let dataJson = JSON(response!)
                    if dataJson["code"] != 200 {
                    } else {
                    let user = EVUser.fromJson(data: dataJson["data"])
                    EVAppFactory.shareInstance.currentUser = user
                        EVController.mainGame.showController(self)
                    }
                }, error: { (error) in
                    log.error(error)
                })
                
            }
//            let loginServerSignal = EVUserServices.shareInstance.login(with: token!, type: "facebook", idUser: nil)
//            
//            loginServerSignal.subscribeNext({ (result) in
//                dispatch_main_queue_safe {
//                    self.stopRotateView()
//                }
//            })
           
            
        }, error: { (error) in
            
        })
    }
    
    @IBAction func loginGoogleAction(_ sender: Any) {
   
        let loginGoogleSignal = EVAuthenticationManager.share().authenticateWithGoogle(in: self)
        loginGoogleSignal?.subscribeNext({ (response) in
            
            guard let userGoogle = response as? GIDGoogleUser else {return}
            var params = Dictionary<String, Any>()
            params["provider_type"] = EVConstant.PROVIDER_GOOGLE
            params["provider_access_token"] = userGoogle.authentication.idToken
            params["provider_id"] = userGoogle.userID
            params["name"] = userGoogle.profile.name
            
            
        
           
            let contentPath = userGoogle.profile.imageURL(withDimension: 100).path
            if !contentPath.isEmpty {
                let headURL = "https://lh3.googleusercontent.com"
                 params["image_url"] = headURL + "\(contentPath)"
            }
            
            let loginServerSignal = EVUserServices.shareInstance.login(with: params)
            loginServerSignal.subscribeNext({ (response) in
               
                let dataJson = JSON(response!)
                if dataJson["code"] == 200 {
                    let user = EVUser.fromJson(data: dataJson["data"])
                    EVAppFactory.shareInstance.currentUser = user
                    EVController.mainGame.showController(self)
                }
               
//                dispatch_main_queue_safe {
//                    if let mainGameVC = StoryBoard.EventGo.viewController("EVMainGameController") as? EVMainGameController {
//                        self.present(mainGameVC, animated: true, completion: nil)
//                    }
                
//                }

            }, error: { (error) in
                
            })
            
        }, error: { (error) in
        
        })
        
    }
    
    func stopRotateView(){
        self.avatarAppView.layer.removeAllAnimations()
        if let tvc = UIStoryboard(name: "EventGo", bundle: nil).instantiateViewController(withIdentifier: "EVMainGameController") as? EVMainGameController {
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
