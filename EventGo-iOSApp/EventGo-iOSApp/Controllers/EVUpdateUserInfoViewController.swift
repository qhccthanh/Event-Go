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
    
    var currentUser: EVUser?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUser = EVAppFactory.shareInstance.currentUser
        setup()
    }
    
    private func setup(){
    
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height
        nameView.placeHolderText = "Họ Tên"
        emailView.placeHolderText = "Email"
        phoneView.placeHolderText = "Phone"
        phoneView.type = .numeric
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.height / 2.0
        self.avatarImageView.layer.masksToBounds = true
        
        guard self.currentUser != nil else {
            return
        }
        
        if let url = URL(string: (currentUser?.image_url)!) {
//            getDataFromUrl(url: url) { (data, response, error)  in
//                guard let data = data, error == nil else { return }
//                print(response?.suggestedFilename ?? url.lastPathComponent)
//                print("Download Finished")
//                DispatchQueue.main.async() { () -> Void in
//                    self.avatarImageView.image = UIImage(data: data)
//                }
//            }
            
             self.avatarImageView.setImageWith(url, placeholderImage: nil)
        }
        
        nameView.text = self.currentUser?.name
        emailView.text = "\(self.currentUser?.age )"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
//        URLSession.shared.dataTask(with: url) {
//            (data, response, error) in
//            completion(data, response, error)
//            }.resume()
//    }
    
    @IBAction func updateInfoAction(_ sender: AnyObject) {
        
        var params = Dictionary<String, Any>()
        params["name"] = self.nameView.text
        let updateSignal: RACSignal = EVUserServices.shareInstance.updateUserInfologin(with: params)
        updateSignal.subscribeNext({ (result) in
            if let result = result as? EVUpdateResult {
                switch result {
                case .success:
                    dispatch_main_queue_safe {
                        if let mainGameVC = StoryBoard.DemoST.viewController("EVMainGameController") as? EVMainGameController {
                            self.present(mainGameVC, animated: true, completion: nil)
                        }
                    }
                    break
                    
                default:
                    //show message failure
                    break
                }
            }

        }, error: { (error) in
            
        })
        
    }

}
