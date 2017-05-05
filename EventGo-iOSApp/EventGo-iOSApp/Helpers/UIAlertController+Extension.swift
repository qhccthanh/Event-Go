//
//  UIAlertController+Extension.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/6/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func showAlert(_ message: String,title: String,sender: UIViewController, doneAction: ( () -> Void )? = nil, cancelAction: ( () -> Void )? = nil) {
        DispatchQueue.main.async(execute: {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                doneAction?()
            }
            alert.addAction(okAction)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) {
                action -> Void in
                cancelAction?()
            }
            alert.addAction(cancelAction)
            sender.present(alert, animated: true, completion: { () in  })
        })
    }
}
