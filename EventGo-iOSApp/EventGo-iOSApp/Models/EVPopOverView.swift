//
//  EVPopOverView.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
class EVPopOverView: UIView {
    
   
    private var imageContentView: UIImageView! = UIImageView()
    private var titleLabel:UILabel! = UILabel()
    private var contentLabel: UILabel! = UILabel()
    private var exitButton: UIButton! = UIButton()
    private var detailButton: UIButton! = UIButton()
    var heightView: CGFloat = 20.0
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func show(content : String) {
        
            customUI()
            self.imageContentView.contentMode = .scaleAspectFit
            self.addSubview(imageContentView)
            self.addSubview(titleLabel)
            self.addSubview(contentLabel)
            self.addSubview(exitButton)
            self.addSubview(detailButton)
        
//            exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
//            detailButton.addTarget(self, action: #selector(detailViewAction), for: .touchUpInside)
        
            contentLabel.text = content
            var heightContentText = content.height(withConstrainedWidth: self.frame.width, font: UIFont.robotoRegular(withSize: 11))
            contentLabel.snp.makeConstraints({ (make) in
                make.leading.equalTo(0)
                make.width.equalTo(self.snp.width)
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.height.equalTo(heightContentText)
            })
            heightView += heightContentText + 10.0
        
            titleLabel.snp.makeConstraints { (make) in
                make.leading.equalTo(0)
                make.width.equalTo(self.snp.width)
                make.top.equalTo(imageContentView.snp.bottom).offset(10)
                make.height.equalTo(30)
            }
        
            heightView += 40
        
            titleLabel.text = "Title"
        
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
            imageContentView.image = UIImage(named: "ic_pagoda")
            imageContentView.backgroundColor = UIColor.blue
            imageContentView.layer.cornerRadius = imageContentView.frame.height / 2.0
            imageContentView.layer.masksToBounds = true
            exitButton.layer.cornerRadius = 10
            exitButton.clipsToBounds = true
            exitButton.layer.backgroundColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1).cgColor
            exitButton.titleLabel?.textColor = UIColor.white
            exitButton.setTitle("Đóng", for: .normal)
            exitButton.setTitleColor(UIColor.white, for: .normal)
            exitButton.layer.borderWidth = 0.2
            exitButton.layer.borderColor = UIColor.blue.cgColor
        
            detailButton.setTitle("Chi tiết", for: .normal)
            detailButton.setTitleColor(UIColor.white, for: .normal)
            detailButton.layer.cornerRadius = 10
            detailButton.clipsToBounds = true
            detailButton.layer.backgroundColor = UIColor(red: 0/255, green: 150/255, blue: 136/255, alpha: 1).cgColor
            detailButton.layer.borderWidth = 0.2
            detailButton.layer.borderColor = UIColor.blue.cgColor
        
    }
    
    func exitAction(callback: () -> Void){
        callback()
    }
    
    func detailViewAction(callback: () -> Void) {
        callback()
    }
    
    private func customUI(){
        
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
