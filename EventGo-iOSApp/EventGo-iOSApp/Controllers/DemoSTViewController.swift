//
//  DemoSTViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/29/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa


public class Teacher: NSObject {
    var name: String?
}

class DemoSTViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        var characters = MutableProperty("")

//        passwordTextField.reactive.textValues.observeValues { (text) in
//            characters.value = text!
//        }
//        var tc = Teacher()
//        tc.rac_values(forKeyPath: "name", observer: tc).subscribeNext { (newValue) in
//           
//        }
        
//        nameTextField.rac_textSignal().subscribeNext { (value) in
//            characters.value = value as! String
//        }
//        passwordTextField.reactive.text <~ characters
//        
//        var filteredUsername: RACSignal? = nameTextField.rac_textSignal().filter({(_ value: Any) -> Bool in
//            var text: String = value as! String
//            return (text.range(of: "Thai") != nil)
//            //            return (text.characters.count ?? 0) > 3
//        })
//
//        filteredUsername?.subscribeNext({ (value) in
//            print(value!)
//        })
//
//        passwordTextField.reactive.continuousTextValues.observeValues { (newValue) in
//            characters.value = newValue!
//        }
//        nameTextField.reactive.text <~ characters
//
        loginButton.reactive.controlEvents(.touchUpInside).observe { _ in
            let loginFacebookSignal = EVAuthenticationManager.share().authenticateWithFacebook(in: self)
            loginFacebookSignal?.subscribeNext({ (response) in
                log.info(response)
            }, error: { (error) in
                print(error)
            })
        }
        
        
//        let nameSignal: Signal = nameTextField.reactive.continuousTextValues
//        let emailSignal: Signal = passwordTextField.reactive.continuousTextValues
//        
//        
//        var combineSignal = Signal.combineLatest([nameSignal, emailSignal]).observeResult { (strs) in
//            if let values = strs.value,
//                let value1 = values[0],
//                let value2 = values[1],
//                value1 == "" && value2 == "dfe"
//            {
//                self.loginButton.isEnabled = true
//            } else {
//                self.loginButton.isEnabled = false
//            }
//        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}
