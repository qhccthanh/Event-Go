//
//  EGoButtonModel.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/25/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit
import ChameleonFramework
class EGoButtonModel: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let leftColor = UIColor(red: 67/255, green: 195/255, blue: 226/255, alpha: 0.8)
        let rightColor = UIColor(red: 24/255, green: 90/255, blue: 157/255, alpha: 0.5)
        self.layer.cornerRadius = 20
        let colorRadient = UIColor(gradientStyle: .leftToRight, withFrame: self.bounds, andColors: [ leftColor, rightColor])
        self.layer.backgroundColor = colorRadient?.cgColor
    }
}
