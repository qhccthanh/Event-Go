//
//  EVUpdateUserInfoViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVUpdateUserInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateInfoAction(_ sender: Any) {
        if let mainGameVC = StoryBoard.DemoST.viewController("EVMainGameController") as? EVMainGameController {
            self.present(mainGameVC, animated: true, completion: nil)
        }
    }

}
