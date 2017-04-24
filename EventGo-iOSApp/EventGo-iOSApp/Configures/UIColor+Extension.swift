//
//  UIColor+Extension.swift
//  QuanLyChiTieu
//
//  Created by Quach Ha Chan Thanh on 12/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import ChameleonFramework

extension UIColor {
    
    class func primaryButtonGradientColor(_ withFrame: CGRect = .zero) -> UIColor {
        let leftColor = UIColor(red: 67.0/255, green: 195.0/255, blue: 226.0/255, alpha: 1)
        let rightColor = UIColor(red: 0/255, green: 128.0/255, blue: 64.0/255, alpha: 1)
        let colorRadient = UIColor(gradientStyle: .leftToRight, withFrame: withFrame, andColors: [ leftColor, rightColor])
        
        return colorRadient!
    }
    
    class func detailButtonBGColor() -> UIColor {
        return UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1)
    }
    
    class func exitButtonBGColor() -> UIColor {
        return UIColor(red: 0/255, green: 150/255, blue: 136/255, alpha: 1)
    }

    
    class func homePageGradientColor(_ withFrame: CGRect = .zero) -> UIColor {
        
        let colorRadient = UIColor(gradientStyle: .leftToRight, withFrame: withFrame, andColors: [ UIColor.egoBase(), UIColor.egoSecondary()])
        
        return colorRadient!
    }
    
}








