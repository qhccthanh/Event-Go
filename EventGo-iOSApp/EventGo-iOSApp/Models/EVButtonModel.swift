//
//  EVButtonModel.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/3/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit

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
        self.layer.cornerRadius = self.frame.height / 2
        let colorRadient = UIColor(gradientStyle: .leftToRight, withFrame: self.bounds, andColors: [ leftColor, rightColor])
        self.layer.backgroundColor = colorRadient?.cgColor
    }
}
