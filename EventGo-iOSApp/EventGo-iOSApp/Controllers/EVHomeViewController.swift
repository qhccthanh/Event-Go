//
//  EVHomeViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/12/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVHomeViewController: EVViewController {

    var homeButton: UIButton = UIButton()
    var animatedView: UIView = UIView()
    var button1: EGoButtonModel = EGoButtonModel()
    var button2: EGoButtonModel = EGoButtonModel()
    var button3: EGoButtonModel = EGoButtonModel()

    
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    private func setupView(){
        self.view.addSubview(homeButton)
        
        homeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.buttonView)
            make.width.height.equalTo(50)
        }
        homeButton.setImage(UIImage(named: "EventGo-Logo"), for: .normal)
        homeButton.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
        
        self.view.addSubview(animatedView)

        animatedView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        animatedView.isHidden = true
        
        self.animatedView.addSubview(button1)
        button1.setImage(UIImage(named: "EventGo-Logo"), for: .normal)
        self.animatedView.addSubview(button2)
        button2.setImage(UIImage(named: "EventGo-Logo"), for: .normal)
        self.animatedView.addSubview(button3)
        button3.setImage(UIImage(named: "EventGo-Logo"), for: .normal)
        

        stopAnimation()
    }
    
    func stopAnimation() {
        
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button1.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(30)
            maker.centerY.centerX.equalTo(self.homeButton)
        }
        
        button2.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(30)
            maker.centerY.centerX.equalTo(self.homeButton)
        }
        
        button3.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(30)
            maker.centerY.centerX.equalTo(self.homeButton)
        }
        self.animatedView.backgroundColor = UIColor.white
        self.animatedView.alpha = 0.0
    }
    
    func startAnimation(){
 
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
       
        button1.center = CGPoint(x: self.homeButton.center.x, y: self.homeButton.center.y - 150)
        button2.center = CGPoint(x: homeButton.center.x - 90, y: self.homeButton.center.y - 120)
        button3.center = CGPoint(x: homeButton.center.x + 90, y: self.homeButton.center.y - 120)
        
    }
    
    func homeButtonAction(){
        animatedView.isHidden = false
        UIView.animate(withDuration: 3) {
            self.animatedView.alpha = 0.9
            self.startAnimation()
        }
    }
    
    override func id() -> String {
        return "EVHomeViewController"
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
