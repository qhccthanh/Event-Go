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
import EZLoadingActivity

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
        dispatch_main_queue_safe {
            EZLoadingActivity.Settings.ActivityWidth = 180
            EZLoadingActivity.Settings.ActivityHeight = 80
            EZLoadingActivity.Settings.FontName = "Roboto-Thin"
            EZLoadingActivity.show("Đang tải", disableUI: false)
        }
    }
    func hideLoading() {
        dispatch_main_queue_safe {
            EZLoadingActivity.Settings.ActivityWidth = 180
            EZLoadingActivity.Settings.ActivityHeight = 80
            EZLoadingActivity.hide()
        }
    }
    
    func hideLoading(text: String) {
        dispatch_main_queue_safe {
            EZLoadingActivity.Settings.ActivityWidth = 180
            EZLoadingActivity.Settings.ActivityHeight = 80
            EZLoadingActivity.show(text, disableUI: false)
        }
    }

    func showLoading(text: String) {
        dispatch_main_queue_safe {
            EZLoadingActivity.Settings.ActivityWidth = 180
            EZLoadingActivity.Settings.ActivityHeight = 80
            EZLoadingActivity.show(text, disableUI: false)
        }
    }
    
    func hideSuccessLoading(success: Bool) {
        dispatch_main_queue_safe {
            EZLoadingActivity.Settings.ActivityWidth = 180
            EZLoadingActivity.Settings.ActivityHeight = 80
            EZLoadingActivity.hide(success, animated: true)
        }
    }
    
    deinit {
        log.debug("\(NSStringFromClass(self.classForCoder))")
    }
}
