//
//  ViewController.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class EVViewController: UIViewController {

    static var currentViewController: EVViewController!
    static var currentNavigationController: EVViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.isKind(of: UINavigationController.classForCoder())) {
            EVViewController.currentNavigationController = self
        } else {
            EVViewController.currentViewController = self
        }
        
        FIRAnalytics.setScreenName("EVViewController", screenClass: "EVViewController")
        log.debug("\(NSStringFromClass(self.classForCoder))")
//        self.view.backgroundColor = UIColor.init(hexString: "#4CAF50")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLoading() {
        
        
        if let loader = UIApplication.shared.windows.first!.viewWithTag(9999) as? MBProgressHUD {
            
            loader.show(animated: true)
        } else {
            
            let loader = MBProgressHUD.showAdded(to: UIApplication.shared.windows.first!, animated: true)
            //            loader.contentColor = UIColor.blue
            //            loader.label.font = UIFont.systemFont(ofSize: 14)
            loader.tag = 9999
            UIApplication.shared.windows.first!.bringSubview(toFront: loader)
        }
        
    }
    func hideLoading() {
        (UIApplication.shared.windows.first!.viewWithTag(9999) as? MBProgressHUD)?.hide(animated: false)
        
    }

    
    deinit {
        log.debug("\(NSStringFromClass(self.classForCoder))")
    }
}
