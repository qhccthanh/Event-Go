//
//  EGoPopupView.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/25/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit


enum EgoPopupType {
    case notification
    case detail
}

class EGoPopupView: UIView {
    
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
        let appearance = SCLAlertView.SCLAppearance( showCloseButton: false)
        let alert = SCLAlertView(appearance: appearance)
        
        switch type {
        case .notification:
            contentLable.frame = CGRect(x: 0, y: 110, width: self.frame.width, height: 60)
            self.imageContentView.frame = CGRect(x: 0, y: 0, width: self.frame.width , height: 100)
            self.imageContentView.image = model.imageItem()
            self.addSubview(imageContentView)
            
            break
            
        default:
            contentLable.frame = CGRect(x: 0, y: 50, width: self.frame.width, height: 60)
            break
        }
        
        if (model.isShowExitButton()){
            alert.addButton("exit", action: { 
                print("đã bấm exit")
            })
        }
        
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


