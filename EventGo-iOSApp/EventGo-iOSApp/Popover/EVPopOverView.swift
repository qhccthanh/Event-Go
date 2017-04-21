//
//  EVPopOverView.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

enum EVPopOverAppearance {
    case fullInfo
    case info
    case loading
}


class EVPopOverView: UIView {
    
   
    private var imageContentView: UIImageView! = UIImageView()
    private var titleLabel:UILabel! = UILabel()
    private var contentLabel: UILabel! = UILabel()
    var exitButton: UIButton! = UIButton()
    var detailButton: UIButton! = UIButton()
    var heightView: CGFloat = 20.0
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
    private func setFullInfoView(icon: UIImage, title: String, content: String){
        self.addSubview(imageContentView)
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(exitButton)
        self.addSubview(detailButton)
  
        titleLabel.text = title
        
        contentLabel.text = content
        let heightContentText = content.height(withConstrainedWidth: self.frame.width, font: UIFont.robotoRegular(withSize: 11))
        contentLabel.snp.makeConstraints({ (make) in
            make.leading.equalTo(0)
            make.width.equalTo(self.snp.width)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(heightContentText)
        })
        heightView += heightContentText + 10.0
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
            make.top.equalTo(imageContentView.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        heightView += 40
        
        imageContentView.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(50)
            
        })
        heightView += 50
        
        exitButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(30)
        }
        heightView += 50
        
        detailButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.leading.equalTo(10)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(30)
        }
        
        imageContentView.layoutIfNeeded()
        imageContentView.image = icon
        imageContentView.layer.cornerRadius = imageContentView.frame.height / 2.0
        imageContentView.layer.masksToBounds = true
        imageContentView.layer.borderColor = UIColor.gray.cgColor
        imageContentView.layer.borderWidth = 0.5
        
        exitButton.layer.cornerRadius = 10
        exitButton.clipsToBounds = true
        exitButton.layer.backgroundColor = UIColor.exitButtonBGColor().cgColor
        exitButton.setTitle("Đóng", for: .normal)
        exitButton.setTitleColor(UIColor.white, for: .normal)
        exitButton.layer.borderWidth = 0.2
        exitButton.layer.borderColor = UIColor.blue.cgColor
        
        detailButton.setTitle("Chi tiết", for: .normal)
        detailButton.setTitleColor(UIColor.white, for: .normal)
        detailButton.layer.cornerRadius = 10
        detailButton.clipsToBounds = true
        detailButton.layer.backgroundColor = UIColor.detailButtonBGColor().cgColor
        detailButton.layer.borderWidth = 0.2
        detailButton.layer.borderColor = UIColor.blue.cgColor

    }
    
    private func setInfoView(icon: UIImage, title: String, content: String){
        self.addSubview(imageContentView)
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(exitButton)

        titleLabel.text = title
        contentLabel.text = content
        let heightContentText = content.height(withConstrainedWidth: self.frame.width, font: UIFont.robotoRegular(withSize: 11))
        contentLabel.snp.makeConstraints({ (make) in
            make.leading.equalTo(0)
            make.width.equalTo(self.snp.width)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(heightContentText)
        })
        heightView += heightContentText + 10.0
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
            make.top.equalTo(imageContentView.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        heightView += 40
        
        imageContentView.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(50)
            
        })
        heightView += 50
        
        exitButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.width.equalTo(70)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        heightView += 50
    
        imageContentView.layoutIfNeeded()
        imageContentView.image = icon
        imageContentView.layer.cornerRadius = imageContentView.frame.height / 2.0
        imageContentView.layer.masksToBounds = true
        imageContentView.layer.borderColor = UIColor.gray.cgColor
        imageContentView.layer.borderWidth = 0.5
        
        exitButton.layer.cornerRadius = 10
        exitButton.clipsToBounds = true
        exitButton.layer.backgroundColor = UIColor.exitButtonBGColor().cgColor
        exitButton.setTitle("Đóng", for: .normal)
        exitButton.setTitleColor(UIColor.white, for: .normal)
        exitButton.layer.borderWidth = 0.2
        exitButton.layer.borderColor = UIColor.blue.cgColor
    }
    
    func setLoadingView(icon: UIImage, title: String, content: String) {
        
        self.addSubview(imageContentView)
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        
        titleLabel.text = title
        contentLabel.text = content
        let heightContentText = content.height(withConstrainedWidth: self.frame.width, font: UIFont.robotoRegular(withSize: 11))
        contentLabel.snp.makeConstraints({ (make) in
            make.leading.equalTo(0)
            make.width.equalTo(self.snp.width)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(heightContentText)
        })
        heightView += heightContentText + 10.0
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
            make.top.equalTo(imageContentView.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        heightView += 40
        
        imageContentView.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(50)
            
        })
        heightView += 50
     
        imageContentView.image = icon
    }
     /*convenience init(frame: CGRect, title :String, content: String) {
        self.init(frame: frame)
        customUI()
        self.imageContentView.contentMode = .scaleAspectFit
        self.addSubview(imageContentView)
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(exitButton)
        self.addSubview(detailButton)
        
        //            exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
        //            detailButton.addTarget(self, action: #selector(detailViewAction), for: .touchUpInside)
        titleLabel.text = title
        
        contentLabel.text = content
        let heightContentText = content.height(withConstrainedWidth: self.frame.width, font: UIFont.robotoRegular(withSize: 11))
        contentLabel.snp.makeConstraints({ (make) in
            make.leading.equalTo(0)
            make.width.equalTo(self.snp.width)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(heightContentText)
        })
        heightView += heightContentText + 10.0
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
            make.top.equalTo(imageContentView.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        heightView += 40
        
        imageContentView.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(50)
            
        })
        heightView += 50
        
        exitButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(30)
        }
        heightView += 50
        
        detailButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.leading.equalTo(10)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(30)
        }
        
        imageContentView.layoutIfNeeded()
        imageContentView.image = EVImage.ic_pagoda.icon()
        imageContentView.layer.cornerRadius = imageContentView.frame.height / 2.0
        imageContentView.layer.masksToBounds = true
        imageContentView.layer.borderColor = UIColor.gray.cgColor
        imageContentView.layer.borderWidth = 0.5
        
        exitButton.layer.cornerRadius = 10
        exitButton.clipsToBounds = true
        exitButton.layer.backgroundColor = UIColor.exitButtonBGColor().cgColor
        exitButton.setTitle("Đóng", for: .normal)
        exitButton.setTitleColor(UIColor.white, for: .normal)
        exitButton.layer.borderWidth = 0.2
        exitButton.layer.borderColor = UIColor.blue.cgColor
        
        detailButton.setTitle("Chi tiết", for: .normal)
        detailButton.setTitleColor(UIColor.white, for: .normal)
        detailButton.layer.cornerRadius = 10
        detailButton.clipsToBounds = true
        detailButton.layer.backgroundColor = UIColor.detailButtonBGColor().cgColor
        detailButton.layer.borderWidth = 0.2
        detailButton.layer.borderColor = UIColor.blue.cgColor
    }*/
    
    convenience init(frame: CGRect, type: EVPopOverAppearance, icon: UIImage, title: String, content: String) {
        self.init(frame: frame)
        customUI()
        switch type {
        case .fullInfo:
            setFullInfoView(icon: icon, title: title, content: content)
            break
        case .info:
            setInfoView(icon: icon, title: title, content: content)
            break
        default:
            setLoadingView(icon: icon, title: title, content: content)
            break
        }
    }
        
    private func customUI(){
        
        imageContentView.layoutIfNeeded()
        imageContentView.layer.cornerRadius = imageContentView.frame.height / 2.0
        imageContentView.layer.masksToBounds = true
        imageContentView.layer.borderColor = UIColor.gray.cgColor
        imageContentView.layer.borderWidth = 0.5
        self.layer.backgroundColor = UIColor.white.cgColor
        self.imageContentView.contentMode = .scaleAspectFit
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLabel.numberOfLines = 0
        contentLabel.sizeToFit()
        contentLabel.textAlignment = .center
        contentLabel.font =  UIFont.robotoRegular(withSize: 11)
        titleLabel.textAlignment = .center
        titleLabel.font =  UIFont.robotoRegular(withSize: 17)
        titleLabel.textColor = UIColor.red
        
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true

    }
}
