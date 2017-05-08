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
import RxSwift
import Pulsator

class EVLogInViewController: EVViewController {

    @IBOutlet weak var avatarAppView: UIView!
    @IBOutlet weak var pulseLogoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.avatarAppView.rotate360Degrees()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _ = Observable<Int>
            .interval(0.6, scheduler: MainScheduler.instance)
            .take(5)
            .subscribe { [weak self] (_) in
                self?.setupPulsator()
        }
    }
    
    func setupPulsator() {
        let pulsator = Pulsator()
        pulsator.animationDuration = 3
        pulsator.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        pulsator.radius = pulseLogoView.getSize().width
        
        pulseLogoView.layer.addSublayer(pulsator)
        pulsator.start()
    }
    
    @IBAction func loginFBAction(_ sender: Any) {
        
        let loginFacebookSignal = EVAuthenticationManager.share().authenticateWithFacebook(in: self)
        loginFacebookSignal?.subscribeNext({ (response) in
            
            if let token = FBSDKAccessToken.current().tokenString{
                var params = Dictionary<String, Any>()
                params["provider_type"] = EVConstant.PROVIDER_FACEBOOK
                params["provider_access_token"] = token
                
                EVAppFactory.users.signIn(with: params)
            }
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
            
            EVAppFactory.users.signIn(with: params)
        }, error: { (error) in
        
        })
        
    }
    
    func stopRotateView() {
        self.avatarAppView.layer.removeAllAnimations()
        if let tvc = UIStoryboard(name: "EventGo", bundle: nil).instantiateViewController(withIdentifier: "EVMainGameController") as? EVMainGameController {
            self.present(tvc, animated: true, completion: nil)
        }
    }

}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 5) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
