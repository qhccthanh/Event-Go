//
//  LaunchScreenViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

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
        Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(self.stopRotateView), userInfo: nil , repeats: false)
    }
//    
//    private func rotateView(targetView: UIView, duration: Double = 1.0) {
//        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
//            targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi))
//        }) { finished in
//            self.rotateView(targetView: targetView, duration: duration)
//            Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.inham), userInfo: nil , repeats: false)
//        }
//    }
//    
    func stopRotateView(){
        self.avatarAppView.layer.removeAllAnimations()
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
