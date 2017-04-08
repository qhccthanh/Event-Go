//
//  EVPopupView.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/25/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit
import SCLAlertView

enum EgoPopupType {
    case notification
    case detail
    case popover
}

class EVPopupView: UIView {
    
    private var contentLable: UILabel! = UILabel()
    private var imageContentView: UIImageView! = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func show(with model : ItemPopupProtocol , type: EgoPopupType, callback: @escaping () -> Void) {
        
        customUI()
        let appearance = SCLAlertView.SCLAppearance( showCloseButton: model.isShowExitButton())
        let alert = SCLAlertView(appearance: appearance)
        switch type {
        case .notification:
            contentLable.frame = CGRect(x: 0, y: 110, width: self.frame.width, height: 60)
            self.imageContentView.frame = CGRect(x: 0, y: 0, width: self.frame.width , height: 100)
            self.addSubview(imageContentView)
            
            break
            
        case .popover:
            contentLable.frame = CGRect(x: 0, y: 30, width: self.frame.width , height: 30)
            self.imageContentView.frame = CGRect(x: 0, y: 0, width: self.frame.width  , height: 30)
            self.imageContentView.contentMode = .scaleAspectFit
            let horizontalConstraint = NSLayoutConstraint(item: imageContentView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: imageContentView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
            self.addConstraints([horizontalConstraint,verticalConstraint])
            imageContentView.image = model.imageItem()
            self.addSubview(imageContentView)
            break
            
        default:
            contentLable.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 60)
            break
        }
        
    
        
//        if (model.isShowExitButton()){
//            alert.addButton("exit", action: { 
//                print("đã bấm exit")
//            })
//        }
        
        if (model.isShowHandleButton()){
            alert.addButton("OK", action: {
                callback()
            })
        }
        
        contentLable.text = model.subTitleItem()
        self.addSubview(contentLable)
        alert.customSubview = self
        alert.showInfo(model.titleItem(), subTitle: "")
    }
    
    private func customUI(){
        
        self.layer.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundColor")!).cgColor
        self.imageContentView.contentMode = .scaleAspectFit
        contentLable.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLable.numberOfLines = 6
        contentLable.textAlignment = .center
        contentLable.font =  UIFont(name: "Georgia", size: 16)
    }
}


