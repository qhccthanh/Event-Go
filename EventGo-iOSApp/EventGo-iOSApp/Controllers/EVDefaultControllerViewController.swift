//
//  EVDefaultControllerViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import SwiftyJSON
class EVDefaultControllerViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let checkUserSignal = EVUserServices.shareInstance.checkInfoUser()
        checkUserSignal.subscribeNext({ (response) in
            let dataJson = JSON(response!)
            if dataJson["code"] == 200 {
                EVAppFactory.shareInstance.currentUser = EVUser.fromJson(data: dataJson["data"])
            } else {
                if let evLoginView = StoryBoard.DemoST.viewController("EVLogInViewController") as? EVLogInViewController {
                    self.present(evLoginView, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
                }
            }
        
        }, error: { (error) in
            
        })

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
