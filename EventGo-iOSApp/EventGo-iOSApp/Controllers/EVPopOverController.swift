//
//  EVPopOverController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVPopOverController: UIViewController {

    
    var detailBlock: ((_ object: AnyObject)->Void)?
    var cancelBlock: (()->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(customView: EVPopOverView, height: CGFloat) {
        super.init(nibName: nil, bundle: nil)
       
        self.view.addSubview(customView)
        
        customView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
            make.width.equalTo(self.view.frame.width * 0.7)
            make.height.equalTo(height)

        }
        
        self.definesPresentationContext = true;
        self.modalPresentationStyle = .overCurrentContext;
        self.view.backgroundColor = UIColor.clear
        
        customView.detailButton.addTarget(self, action: #selector(detailAction), for: .touchUpInside)
        customView.exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
    }
    
    func showView(_ vc: UIViewController, detailBlock: ((_ object: AnyObject?)-> Void)? = nil, cancelBlock: (() -> Void)? = nil ){
        vc.present(self, animated: true, completion: nil)
        if detailBlock != nil {
            self.detailBlock = detailBlock
        }
        if cancelBlock != nil {
            self.cancelBlock = cancelBlock
        }
    }
    
    @objc private func exitAction() {
        self.cancelBlock?()
    }
    
    @objc private func detailAction() {
        self.detailBlock?("show detail" as AnyObject)
    }

    
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
