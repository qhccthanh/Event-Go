//
//  EVAppFactory.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/22/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

public class EVAppFactory: NSObject {
    
    static var shareInstance: EVAppFactory = EVAppFactory()
    
    public var currentUser: EVUser?
    public var currentEvents: [EVEvent]?
    private static var toast: Toast!
    
    private override init() {
        super.init()
        
    }
    
    public func signIn(_ userInfo: NSDictionary) -> RACSignal<AnyObject> {
        // Check access_token
        return RACSignal.empty()
    }
    
    public func signOut() {
        
    }
    
    class func showHUD(_ labelText: String = "Đang xử lý") {
        
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: UIApplication.keyWindow()!, animated: true)
        hud.mode = .indeterminate
        hud.labelText = labelText
        UIApplication.keyWindow()?.layoutIfNeeded()
    }
    
    class func hideAllHUD() {
        
        MBProgressHUD.hideAllHUDs(for: UIApplication.keyWindow()!, animated: false)
    }
    
    class func showToast(_ mesage: String, duration: TimeInterval = Delay.short) {
        if toast != nil {
            toast.cancel()
        }
        toast = Toast.init(text: mesage, duration: duration)
        toast.show()
    }
    
    class func showAlertWithMessage(_ title: String, message: String) {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        })
    }
    
    @available(iOS 8.0,*)
    class func showAlertOKCancel(_ message: String,title: String,sender: UIViewController, doneAction: ( () -> Void )?, cancelAction: ( () -> Void )? ) {
        
        DispatchQueue.main.async(execute: {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                if let action = doneAction {
                    action()
                }
            }
            alert.addAction(okAction)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) {
                action -> Void in
                if let action = cancelAction {
                    action()
                }
            }
            alert.addAction(cancelAction)
            sender.present(alert, animated: true, completion: { () in  })
        })
    }
    
    class func showAlertTextField(_ title: String?,
                                      message: String?,
                                      controller: UIViewController,
                                      titleDone: String = "Save",
                                      titleCancel: String = "Cancel",
                                      placeHolderTextFields: [String],
                                      doneBlock: (([String?]) -> Void)?, cancelBlock: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: titleDone, style: .default, handler: {
            alert -> Void in
            
            let textFields = alertController.textFields!.map({ (textField) -> String? in
                return textField.text
            })
            
            doneBlock?(textFields)
        })
        
        let cancelAction = UIAlertAction(title: titleCancel, style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            cancelBlock?()
        })
        
        for placeHolder in placeHolderTextFields {
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = placeHolder
            }
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
    
}

