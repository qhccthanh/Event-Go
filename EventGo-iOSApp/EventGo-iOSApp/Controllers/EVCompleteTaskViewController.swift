//
//  EVCompleteTaskViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/16/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVCompleteTaskViewController: EVViewController {

    @IBOutlet weak var chooseImageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderLayer  = dashedBorderLayerWithColor(color: UIColor.black.cgColor)
        chooseImageView.layer.addSublayer(borderLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }
    
    
    func dashedBorderLayerWithColor(color:CGColor) -> CAShapeLayer {
        
        let  borderLayer = CAShapeLayer()
        borderLayer.name  = "borderLayer"
        let frameSize = self.chooseImageView.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width,height: frameSize.height)
        
        borderLayer.bounds=shapeRect
        borderLayer.position = CGPoint(x: frameSize.width / 2,y: frameSize.height/2)
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color
        borderLayer.lineWidth = 1
        borderLayer.lineJoin = kCALineJoinRound
        borderLayer.lineDashPattern = NSArray(array: [NSNumber(value: 8),NSNumber(value:4)]) as? [NSNumber]
        
        let path = UIBezierPath.init(roundedRect: shapeRect, cornerRadius: 0)
        
        borderLayer.path = path.cgPath
        
        return borderLayer
        
    }
   
}
