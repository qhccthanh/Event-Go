//
//  EVHomeViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/12/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

import JDAnimationKit
import RxSwift
import RxCocoa

class EVHomeBottom {
    
    var arrayButton: [EGoButtonModel] = [EGoButtonModel(),EGoButtonModel(),EGoButtonModel(), EGoButtonModel()]
    var homeButton: UIButton = UIButton()
    var animatedView: UIView = UIView()
    
    let subItemButtonHeight: CGFloat = 40
    let mainMenuButtonHeight: CGFloat = 60
    let animationDuration: Double = 0.25
    let animatedBackgroundColor: UIColor = UIColor.teal().withAlphaComponent(0.65)
    
    init(viewController: EVViewController!) {
        self.evViewController = viewController
        settupView()
    }
    
    weak var evViewController: EVViewController!
    var rootView: UIView {
        get {
            return evViewController.view
        }
    }
    
    func settupView() {
        self.rootView.addSubview(homeButton)
        
        homeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.rootView)
            make.bottom.equalTo(self.rootView).offset(-30)
            make.width.height.equalTo(mainMenuButtonHeight)
        }
        homeButton.setImage(EVImage.ic_app_3d.icon(), for: .normal)
        homeButton.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
        arrayButton[3].addTarget(self, action: #selector(cancelAnimatedView), for: .touchUpInside)
        
        self.rootView.addSubview(animatedView)
        
        animatedView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.rootView)
        }
        
        animatedView.isHidden = true
        self.animatedView.backgroundColor = animatedBackgroundColor
        
        self.animatedView.addSubview(arrayButton[0])
        arrayButton[0].setImage(EVImage.ic_bag.icon(), for: .normal)
        arrayButton[0].addTarget(self, action: #selector(showListEvent), for: .touchUpInside)
        self.animatedView.addSubview(arrayButton[1])
        arrayButton[1].setImage(EVImage.ic_checklist.icon(), for: .normal)
        self.animatedView.addSubview(arrayButton[2])
        arrayButton[2].setImage(EVImage.ic_run.icon(), for: .normal)
        self.animatedView.addSubview(arrayButton[3])
        arrayButton[3].setImage(EVImage.ic_quit.icon(), for: .normal)
        
        stopAnimation()
        animationHomeButton()
    }
    
    func animationHomeButton() {
        _ = Observable<Int>
            .interval(0.6, scheduler: MainScheduler.instance)
            .subscribe { [weak self] (time) in
                guard let timeT = time.element else {
                    return
                }
                
                switch timeT % 6 {
                case 0:
                    _ = self?.homeButton.scaleTo(1.15, scaleY: 1.15, duration: 0.25)
                case 1:
                    _ = self?.homeButton.scaleTo(1.25, scaleY: 1.25, duration: 0.25)
                case 2:
                    _ = self?.homeButton.rotateTo(360, duration: 0.5)
                case 3:
                    _ = self?.homeButton.scaleTo(1.15, scaleY: 1.15, duration: 0.25)
                case 4:
                    _ = self?.homeButton.scaleTo(1, scaleY: 1, duration: 0.25)
                case 5:
                    _ = self?.homeButton.rotateTo(0, duration: 0.5)
                default:
                    break
                }       
        }
    }
    
    @objc func showListEvent() {
        self.quitAnimatedView {
            EVController.listEvents.showController(self.evViewController)
        }
    }
    
    @objc func quitAnimatedView(_ successBlock: (() -> Void)? = nil) {
        
        UIView.animate(withDuration: animationDuration, animations: { 
            self.arrayButton[0].center = self.arrayButton[3].center
            self.arrayButton[1].center = self.arrayButton[3].center
            self.arrayButton[2].center = self.arrayButton[3].center
            self.animatedView.alpha = 0.0
        }) { (_) in
            successBlock?()
        }
    }
    
    @objc func cancelAnimatedView() {
        self.quitAnimatedView()
    }
    
    func stopAnimation() {
        
        arrayButton[0].isHidden = true
        arrayButton[1].isHidden = true
        arrayButton[2].isHidden = true
        arrayButton[3].isHidden = true
        arrayButton[0].snp.makeConstraints { (maker) in
            maker.width.height.equalTo(subItemButtonHeight)
            maker.centerY.centerX.equalTo(self.homeButton)
        }
        
        arrayButton[1].snp.makeConstraints { (maker) in
            maker.width.height.equalTo(subItemButtonHeight)
            maker.centerY.centerX.equalTo(self.homeButton)
        }
        
        arrayButton[2].snp.makeConstraints { (maker) in
            maker.width.height.equalTo(subItemButtonHeight)
            maker.centerY.centerX.equalTo(self.homeButton)
        }
        
        arrayButton[3].snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.homeButton)
            make.width.height.equalTo(mainMenuButtonHeight)
            
        }
        
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
    
    @objc func homeButtonAction(){
        animatedView.isHidden = false
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
            self.animatedView.alpha = 1.0
            self.startAnimation()
        }, completion: nil)
    }

    
}

class EVMainBottomModel {

    var nameUser:UILabel = UILabel()
    var avatarImageView:UIImageView = UIImageView()
    var brrowLabel: UILabel = UILabel()
    var blueLabel: UILabel = UILabel()

    var arrayButton: [EGoButtonModel] = [EGoButtonModel(),EGoButtonModel(),EGoButtonModel(), EGoButtonModel()]
    weak var mainGameController: EVMainGameController!
    var rootView: UIView {
        get {
            return mainGameController.mainMapView
        }
    }
    
    @IBOutlet weak var buttonView: UIView!
    
    init(gameControler: EVMainGameController) {
        self.mainGameController = gameControler
        setupView()
        
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.setupView()
//    }
    
    private func setupView(){
        
        let user = EVAppFactory.shareInstance.currentUser
        
        let viewContain = UIView()
        self.rootView.addSubview(viewContain)
        
        viewContain.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.rootView.snp.bottom)
            make.leading.equalTo(self.rootView.snp.leading)
            make.height.equalTo(35)
            let temp = self.rootView.frame.width * 1 / 3
            make.width.equalTo(temp)
        }
        
//        viewContain.layer.backgroundColor = UIColor(averageColorFrom: EVImage.backgroundColor.icon()).cgColor
        viewContain.ev_cornerRadius = 10.0
        let backgroundImage: UIImageView = UIImageView()
        viewContain.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { (make) in
            make.bottom.top.leading.right.equalTo(viewContain)
        }
        backgroundImage.image = EVImage.backgroundColor.icon()
        backgroundImage.layer.cornerRadius = 10.0
        
        viewContain.addSubview(nameUser)
        rootView.addSubview(brrowLabel)
        rootView.addSubview(avatarImageView)
        rootView.addSubview(blueLabel)
        brrowLabel.layer.backgroundColor = UIColor.gray.cgColor
        
        if let user = user {
             nameUser.text = user.name
            if let url = URL(string: user.image_url!) {
                dispatch_main_queue_safe {
                    self.avatarImageView.af_setImage(withURL: url)
                }
            }
           
        }
       
        
        nameUser.snp.makeConstraints {(make) in
            make.bottom.equalTo(viewContain.snp.bottom).offset(-10)
            make.leading.equalTo(viewContain).offset(10)
            make.trailing.equalTo(viewContain.snp.trailing).offset(-10)
            make.height.equalTo(20)
        }
        nameUser.font = UIFont(name: "Avenir-Light", size: 12.0)
        
        
        brrowLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.nameUser.snp.top).offset(-10)
            make.trailing.equalTo(viewContain.snp.trailing).offset(-10)
            make.leading.equalTo(nameUser.snp.leading)
            make.height.equalTo(6)
        }
        
        blueLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.nameUser.snp.leading)
            make.centerY.equalTo(self.brrowLabel.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(4)
        }
        blueLabel.layer.backgroundColor = UIColor.teal().cgColor
        
        
        avatarImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(64)
            make.leading.equalTo(nameUser.snp.leading)
            make.bottom.equalTo(self.brrowLabel.snp.top)
        }
        avatarImageView.image = EVImage.ic_logo.icon()
        avatarImageView.layer.borderWidth = 2.0
        avatarImageView.layer.borderColor = UIColor.darkGray.cgColor
        avatarImageView.ev_cornerRadius = 32
        
        avatarImageView.contentMode = .scaleAspectFill
        
        if let user =  EVAppFactory.shareInstance.currentUser {
            if let url = URL(string: user.image_url!) {
                self.avatarImageView.setImageWith(url)
            }
            nameUser.text = user.name
        }
    }
    
}
