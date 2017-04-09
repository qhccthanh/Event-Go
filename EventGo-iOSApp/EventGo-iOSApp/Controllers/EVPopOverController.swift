//
//  EVPopOverController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVPopOverController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(customView: UIView, height: CGFloat) {
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
        
    }
    
    func showView(_ vc: UIViewController) {
        vc.present(self, animated: true, completion: nil)
    }
    
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
