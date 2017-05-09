//
//  EVDefaultControllerViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import Pulsator
import RxSwift
import RxCocoa

class EVDefaultViewController: EVViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var backgroundLogoView: UIView!
    @IBOutlet weak var pulseLogoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Observable<Any>
            .empty()
            .timeout(Double(2.4), scheduler: MainScheduler.instance)
            .subscribe { [unowned self] (_) in
            EVAppFactory.users.authorizedUser(self)
        }
        logoImageView.rotate360Degrees()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _ = Observable<Int>
            .interval(0.6, scheduler: MainScheduler.instance)
            .take(5)
            .subscribe { [weak self] (_) in
               self?.setupPulsator()
        }
        
        _ = Observable<Int>
            .interval(0.4, scheduler: MainScheduler.instance)
            .delay(0.3, scheduler: MainScheduler.instance)
            .subscribe { [weak self] (time) in
                guard let timeT = time.element else {
                    return
                }
                
                if timeT % 2 == 0 {
                    _ = self?.logoImageView.scaleTo(1.25, scaleY: 1.25, duration: 0.4)
                } else {
                    _ = self?.logoImageView.scaleTo(1, scaleY: 1, duration: 0.4)
                }
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

}
