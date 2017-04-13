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
//    var button1: EGoButtonModel = EGoButtonModel()
//    var button2: EGoButtonModel = EGoButtonModel()
//    var button3: EGoButtonModel = EGoButtonModel()
    var arrayButton: [EGoButtonModel] = [EGoButtonModel(),EGoButtonModel(),EGoButtonModel(), EGoButtonModel()]

    
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
        homeButton.setImage(EVImage.ic_logo.icon(), for: .normal)
        homeButton.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
        arrayButton[3].addTarget(self, action: #selector(quitAnimatedView), for: .touchUpInside)
        
        self.view.addSubview(animatedView)

        animatedView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        animatedView.isHidden = true
        
        self.animatedView.addSubview(arrayButton[0])
        arrayButton[0].setImage(EVImage.ic_bag.icon(), for: .normal)
        self.animatedView.addSubview(arrayButton[1])
        arrayButton[1].setImage(EVImage.ic_checklist.icon(), for: .normal)
        self.animatedView.addSubview(arrayButton[2])
        arrayButton[2].setImage(EVImage.ic_run.icon(), for: .normal)
        self.animatedView.addSubview(arrayButton[3])
        arrayButton[3].setImage(EVImage.ic_quit.icon(), for: .normal)
        
        stopAnimation()
    }
    
    func quitAnimatedView(){
        UIView.animate(withDuration: 1) { 
            self.arrayButton[0].center = self.arrayButton[3].center
            self.arrayButton[1].center = self.arrayButton[3].center
            self.arrayButton[2].center = self.arrayButton[3].center
            self.animatedView.alpha = 0.0
            
        }
    }
    
    func stopAnimation() {
        
        arrayButton[0].isHidden = true
        arrayButton[1].isHidden = true
        arrayButton[2].isHidden = true
        arrayButton[3].isHidden = true
        arrayButton[0].snp.makeConstraints { (maker) in
            maker.width.height.equalTo(30)
            maker.centerY.centerX.equalTo(self.homeButton)
        }
        
        arrayButton[1].snp.makeConstraints { (maker) in
            maker.width.height.equalTo(30)
            maker.centerY.centerX.equalTo(self.homeButton)
        }
        
        arrayButton[2].snp.makeConstraints { (maker) in
            maker.width.height.equalTo(30)
            maker.centerY.centerX.equalTo(self.homeButton)
        }
        
        arrayButton[3].snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.homeButton)
            make.width.height.equalTo(50)
            
        }
        self.animatedView.backgroundColor = UIColor.teal()
        self.animatedView.alpha = 0.0
    }
    
    func startAnimation(){
 
        arrayButton[0].isHidden = false
        arrayButton[1].isHidden = false
        arrayButton[2].isHidden = false
        arrayButton[3].isHidden = false
      

       
        arrayButton[0].center = CGPoint(x: self.homeButton.center.x, y: self.homeButton.center.y - 150)
        arrayButton[1].center = CGPoint(x: homeButton.center.x - 90, y: self.homeButton.center.y - 120)
        arrayButton[2].center = CGPoint(x: homeButton.center.x + 90, y: self.homeButton.center.y - 120)
        
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
