//
//  LoginViewController.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/23/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient: CAGradientLayer = CAGradientLayer()
        let colorTop = UIColor(red: 235/255.0, green: 253.0/255.0, blue: 244.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 250/255.0, green: 255.0/255.0, blue: 209.0/255.0, alpha: 1.0).cgColor
        gradient.frame = self.view.bounds
        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func loginFaceBookAction(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error == nil {
                
            } else {
                print(error!)
            }
        }
    }
    
    @IBAction func loginGoogleAction(_ sender: Any) {
       
    }
}
