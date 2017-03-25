//
//  LineView.swift
//  QuanLyChiTieu
//
//  Created by Quach Ha Chan Thanh on 11/16/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class LineHorizontalView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let sortaPixel = 1.0 / UIScreen.main.scale
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: sortaPixel))
        line.isUserInteractionEnabled = false
        line.backgroundColor = self.backgroundColor
        line.autoresizingMask = .flexibleWidth
        self.addSubview(line)
        
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
    }
}

class LineVerticalView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let sortaPixel = 1.0 / UIScreen.main.scale
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: sortaPixel, height: self.frame.height))
        line.isUserInteractionEnabled = false
        line.backgroundColor = self.backgroundColor
        line.autoresizingMask = .flexibleWidth
        self.addSubview(line)
        
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        
    }
}
