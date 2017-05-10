//
//  EVPopupView.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/25/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit
import SCLAlertView
import SnapKit

enum EgoPopupType {
    case notification
    case detail
    case popover
}

class EVPopupView: UIView {
    
    private var contentLabel: UILabel! = UILabel()
    private var imageContentView: UIImageView! = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func show(with model : ItemPopupProtocol , type: EgoPopupType, callback: @escaping () -> Void) {
        
        customUI()
        let appearance = SCLAlertView.SCLAppearance(kWindowWidth: self.getSize().width + 10,
                                                    kWindowHeight: 250,
                                                    showCloseButton: model.isShowExitButton())
        
        let alert = SCLAlertView(appearance: appearance)
        switch type {
        case .notification:
            contentLabel.frame = CGRect(x: 0, y: 110, width: self.frame.width, height: 60)
            self.imageContentView.frame = CGRect(x: 0, y: 0, width: self.frame.width , height: 100)
            self.addSubview(imageContentView)
            
            break
            
        case .popover:


            self.imageContentView.contentMode = .scaleAspectFit
            self.addSubview(imageContentView)
            self.addSubview(contentLabel)
//             contentLabel.frame = CGRect(x: 0, y: 30, width: self.frame.width , height: 30)
            contentLabel.snp.makeConstraints({ (make) in
                make.leading.equalTo(0)
                make.top.height.equalTo(30)
                make.width.equalTo(self.snp.width)
            })
            
//            self.imageContentView.frame = CGRect(x: 0, y: 0, width: self.frame.width  , height: 30)
            imageContentView.snp.makeConstraints({ (make) in
                make.top.equalTo(0)
                make.centerX.equalToSuperview()
                make.height.width.equalTo(30)
                
            })
            
            imageContentView.image = model.imageItem()
            break
        default:
            contentLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 60)
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
        
        contentLabel.text = model.subTitleItem()
        alert.customSubview = self
//        alert.showInfo(model.titleItem(), subTitle: "")
//        alert.showCustom(model.titleItem(), subTitle: "", color: .white, icon: model.imageItem() ?? UIImage())
    }
    
    private func customUI(){
        
        self.layer.backgroundColor = UIColor(patternImage: EVImage.backgroundColor.icon()!).cgColor
        self.imageContentView.contentMode = .scaleAspectFit
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLabel.numberOfLines = 6
        contentLabel.textAlignment = .center
        // Dung font roboto
        contentLabel.font =  UIFont.robotoRegular(withSize: 16)
    }
}


