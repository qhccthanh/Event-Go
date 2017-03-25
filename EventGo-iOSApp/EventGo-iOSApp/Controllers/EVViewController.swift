//
//  ViewController.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import Firebase

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
        self.view.backgroundColor = .blue
        // verbose
        // debug
        // warn
        // info
    }
    
    func injected() {
        
        self.view.backgroundColor = .yellow
        
        if self.presentedViewController == nil {
            self.present(tViewController(), animated: true, completion: nil)
        } else {
            self.presentedViewController?.dismiss(animated: false, completion: { 
                self.present(tViewController(), animated: true, completion: nil)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        log.debug("\(NSStringFromClass(self.classForCoder))")
    }
}

class tViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        setupView()
    }
    
    func setupView() {
        
        let tView = UIView(frame: .zero)
        tView.frame.size = CGSize(width: 50, height: 100)
        tView.setCenterInView(self.view)
        tView.backgroundColor = .white
        
        self.view.addSubview(tView)
    }
}

