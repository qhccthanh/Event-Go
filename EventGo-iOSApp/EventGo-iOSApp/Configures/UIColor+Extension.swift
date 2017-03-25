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
    
    class func primaryButtonGradientColor() -> UIColor {
        let leftColor = UIColor(red: 67.0/255, green: 195.0/255, blue: 226.0/255, alpha: 1)
        let rightColor = UIColor(red: 24.0/255, green: 90.0/255, blue: 157.0/255, alpha: 1)
        let colorRadient = UIColor(gradientStyle: .leftToRight, withFrame: CGRect.zero, andColors: [ leftColor, rightColor])
        
        return colorRadient!
    }
    
}








