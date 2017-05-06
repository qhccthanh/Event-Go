//
//  EVDefaultControllerViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

import SwiftyJSON
import RxSwift

class EVDefaultControllerViewController: EVViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUser()
    }
    
    func checkUser() {
        _ = EVUserServices.shareInstance
            .authorizedUser()
            .subscribe(onNext: { (result) in
                switch result {
                case .login:
                    EVController.mainGame.showController(self)
                    break
                    
                case .notLogin:
                    EVController.logIn.showController(self)
                    break
                    
                default:
                    EVController.userInfo.showController(self)
                    break
                }
            }, onError: { (error) in
                // toast lên hay alert lên
            })
    }
}
