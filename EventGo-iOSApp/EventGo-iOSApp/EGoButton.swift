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
        
        let leftColor = UIColor(red: 67.0/255, green: 195.0/255, blue: 226.0/255, alpha: 1)
        let rightColor = UIColor(red: 24.0/255, green: 90.0/255, blue: 157.0/255, alpha: 1)
        let colorRadient = UIColor(gradientStyle: .leftToRight, withFrame: self.frame, andColors: [ leftColor, rightColor])
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.backgroundColor = colorRadient?.cgColor
    }
}
