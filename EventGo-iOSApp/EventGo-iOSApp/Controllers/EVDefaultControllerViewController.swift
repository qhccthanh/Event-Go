//
//  EVDefaultControllerViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import SwiftyJSON
class EVDefaultControllerViewController: EVViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let checkUserSignal = EVUserServices.shareInstance.checkInfoUser()
//        checkUserSignal.subscribeNext({ (response) in
//            
//            let dataJson = JSON(response!)
//            dispatch_main_queue_safe {
//                if dataJson["code"] == 200 {
//                    let userCurrent = EVUser.fromJson(data: dataJson["data"])
//                    log.info(dataJson)
//                    EVAppFactory.shareInstance.currentUser = userCurrent
//                    if (userCurrent.image_url == "" || userCurrent.name == "") {
//                        
//                        if let evChangeInfoVC = StoryBoard.DemoST.viewController("EVUpdateUserInfoViewController") as? EVUpdateUserInfoViewController{
//                            self.present(evChangeInfoVC, animated: true, completion: nil)
//                        }
//                    }else {
//                        
//                        if let evMainGameVC = StoryBoard.DemoST.viewController("EVMainGameController") as? EVMainGameController{
//                            self.present(evMainGameVC, animated: true, completion: nil)
//                        }
//                    }
//                    
//                } else {
//                    
//                    if let evLoginView = StoryBoard.DemoST.viewController("EVLogInViewController") as? EVLogInViewController {
//                        self.present(evLoginView, animated: true, completion: nil)
//                    }
//                }
//                
//            }
//        
//        }, error: { (error) in
//            log.error()
//        })
//
//    
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let checkUserSignal = EVUserServices.shareInstance.checkInfoUser()
        checkUserSignal.subscribeNext({ (response) in
            
            if let response = response as? EVCheckUserEnumType {
                
                
                    switch response {
                    case .login:
//                        if let evMainGameVC = StoryBoard.DemoST.viewController("EVMainGameController") as? EVMainGameController{
//                            self.present(evMainGameVC, animated: true, completion: nil)
//                        }
                        EVController.EVMainGameController.showController(self)
                        break
                        
                    case .notLogin:
//                        if let evLoginView = StoryBoard.DemoST.viewController("EVLogInViewController") as? EVLogInViewController {
//                            self.present(evLoginView, animated: true, completion: nil)
//                        }
                        EVController.EVLogInViewController.showController(self)
                        break
                        
                    default:
//                        if let evChangeInfoVC = StoryBoard.DemoST.viewController("EVUpdateUserInfoViewController") as? EVUpdateUserInfoViewController{
//                            self.present(evChangeInfoVC, animated: true, completion: nil)
//                        }
                        EVController.EVUpdateUserInfoViewController.showController(self)
                        break
                    }
                
            }
            
            
        }, error: { (error) in
            log.error()
        })
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
