//
//  UIView+Extension.swift
//  TFDictionary
//
//  Created by qhcthanh on 7/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

import Foundation
import UIKit

class CircleView: UIView {
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
        
    }
    
}

class DashView: UIView {
    override func layoutSubviews() {
        self.layer.masksToBounds = true
        self.layer.masksToBounds = true
        let  borderLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width,height: frameSize.height)
        borderLayer.bounds=shapeRect
        borderLayer.position = CGPoint(x: frameSize.width / 2,y: frameSize.height/2)
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.gray.cgColor
        borderLayer.lineWidth = 1
        borderLayer.lineJoin = kCALineJoinRound
        borderLayer.lineDashPattern = [8,4]
        
        let path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        borderLayer.path = path
        self.layer.addSublayer(borderLayer)
    }
}

enum StoryBoard: String {
    
    
    case EventGo = "EventGo"
    case Search = "Search"
  
    func viewController(_ name: String) -> UIViewController {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: name)
    }
}

extension UIView {
    
    func getSize() -> CGSize {
        return frame.size
    }
    
    func getOrigin() -> CGPoint {
        return frame.origin
    }
    
    func getRightX() -> CGFloat {
        return frame.origin.x + frame.size.width
    }
    
    func getBottomY() -> CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    func setCenterVerticalInSize(_ size: CGSize) {
        self.frame.origin.y = size.height/2 - getSize().height/2
    }
    
    func setCenterHorizontalInSize(_ size: CGSize) {
        self.frame.origin.x = size.width/2 - getSize().width/2
    }
    
    func setCenterInView(_ view: UIView) {
        let size = view.getSize()
        self.frame.origin.y = size.height/2 - getSize().height/2
        self.frame.origin.x = size.width/2 - getSize().width/2
    }
    
  
        
        func dropShadow() {
            
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: -1, height: 1)
//            self.layer.shadowRadius = 5
            
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
        }
    
    
    @IBInspectable var ev_borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var ev_borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var ev_cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
}


extension UIApplication {
    
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController , top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base
    }

    class func keyWindow() -> UIWindow? {
        return UIApplication.shared.keyWindow
    }
}

extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.isHidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.isHidden = false
    }
    
    fileprivate func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
}

