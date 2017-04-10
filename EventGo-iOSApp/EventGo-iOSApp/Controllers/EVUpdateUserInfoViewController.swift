//
//  EVUpdateUserInfoViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import AnimatedTextInput
class EVUpdateUserInfoViewController: UIViewController {

    @IBOutlet weak var nameView: AnimatedTextInput!
    @IBOutlet weak var emailView: AnimatedTextInput!
    @IBOutlet weak var phoneView: AnimatedTextInput!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
    
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height
        nameView.placeHolderText = "Họ Tên"
        emailView.placeHolderText = "Email"
        phoneView.placeHolderText = "Phone"
        phoneView.type = .numeric
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateInfoAction(_ sender: AnyObject) {
        if let mainGameVC = StoryBoard.DemoST.viewController("EVMainGameController") as? EVMainGameController {
            self.present(mainGameVC, animated: true, completion: nil)
        }
    }

}
