//
//  UIView+DashLine.swift
//  QuanLyChiTieu
//
//  Created by Quach Ha Chan Thanh on 11/27/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

class DashLine: UIView {
    
    func addDashedLine(color: UIColor = UIColor.lightGray) {
        _ = layer.sublayers?.filter({ $0.name == "DashedTopLine" }).map({ $0.removeFromSuperlayer() })
        self.backgroundColor = UIColor.clear
        let cgColor = color.cgColor
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.name = "DashedTopLine"
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = cgColor
        shapeLayer.lineWidth = 2.0 / UIScreen.main.scale
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [1, 2]
        
        let path: CGMutablePath = CGMutablePath()
        
        path.move(to: CGPoint.zero)
        
        let endPoint = self.getSize().width > self.getSize().height ? CGPoint(x: self.frame.width,y:0) :  CGPoint(x: 0,y:self.frame.height)
        path.addLine(to:endPoint)
        
        shapeLayer.path = path
        
        self.layer.addSublayer(shapeLayer)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addDashedLine()
    }
    
}
