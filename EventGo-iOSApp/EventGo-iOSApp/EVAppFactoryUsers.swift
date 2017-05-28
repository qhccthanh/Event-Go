//
//  EVAppFactoryUsers.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/6/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

public struct EVAppFactoryUsers {
    
    public func signIn(with params: [String:Any]) {
        _ = EVUserServices
            .signIn(with: params)
            .subscribe(onNext: { (json) in
                
                if json["code"] != 200 {
                    // show message
                    return
                }
                
                let t = json["data"]
                let user = EVUser.fromJson(data: t)
                EVAppFactory.shareInstance.currentUser = user
                EVController.mainGame.showController()
            }, onError: { (_) in
                // show message
            })
    }
    
    public func signOut() {
        _ = EVUserServices
            .signOut()
            .subscribe(onNext: { (json) in
                
            }, onError: { (error) in
                
            })
    }
    
    public func updateDeviceInfo() {
        
        var params = Dictionary<String, Any>()
        let device = EVDevice(model: UIDevice.current.name, iosVersion: UIDevice.current.systemVersion)
        
        params["device"] = device.toJson()
        
        
        _ = EVUserServices
            .updateDeviceInfo(with: params)
            .subscribe(onNext: { (result) in
                log.info("Update device info: ")
                log.info(result)
        }, onError: { (error) in
                log.error(error)
        })
    }
    
    public func authorizedUser(_ inController: UIViewController? = nil) {
        _ = EVUserServices
            .authorizedUser()
            .subscribe(onNext: { (result) in
                switch result {
                case .login:
                    EVController.mainGame.showController(inController)
                    break
                case .notLogin:
                    EVController.logIn.showController(inController)
                    break
                case .updatedInfo:
                    EVController.userInfo.showController(inController)
                    break
                }
            }, onError: { (error) in
                // toast lên hay alert lên
                EVController.logIn.showController(inController)
            })
    }
    
    public func updateUserInfo(params: [String: Any]) {
        _ = EVUserServices
            .updateUserInfo(with: params)
            .subscribe(onNext: { (result) in
                switch result {
                case .success:
                    //                    dispatch_main_queue_safe {
                    //                        if let mainGameVC = StoryBoard.EventGo.viewController("EVMainGameController") as? EVMainGameController {
                    //                            self.present(mainGameVC, animated: true, completion: nil)
                    //                        }
                    EVController.mainGame.showController()
                    break
                default:
                    //show message failure
                    break
                }
            }, onError: { (error) in
                //show message failure
            })
    }
    
}
