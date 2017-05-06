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
        
        EVAppFactory.users.authorizedUser(self)
    }

}
