//
//  EGoButtonModel.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/25/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit

class EGoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        
        let colorRadient = UIColor.primaryButtonGradientColor()
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.backgroundColor = colorRadient.cgColor
    }
}
