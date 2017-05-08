//
//  EVDefaultControllerViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import Pulsator

class EVDefaultControllerViewController: EVViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pulsator = Pulsator()
        avatarImageView.layer.addSublayer(pulsator)
        pulsator.start()
        //EVAppFactory.users.authorizedUser(self)
    }

}
