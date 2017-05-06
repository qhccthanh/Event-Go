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
        _ = EVUserServices.shareInstance
            .signIn(with: params)
            .subscribe(onNext: { (json) in
                
                if json["code"] != 200 {
                    // show message
                    return
                }
                
                let user = EVUser.fromJson(data: json["data"])
                EVAppFactory.shareInstance.currentUser = user
                EVController.mainGame.showController()
            }, onError: { (_) in
                // show message
            })
    }
    
    public func signOut() {
        _ = EVUserServices.shareInstance
            .signOut()
            .subscribe(onNext: { (json) in
                
            }, onError: { (error) in
                
            })
    }
    
    public func updateDeviceInfo() {
        
        var params = Dictionary<String, Any>()
        let device = EVDevice(model: UIDevice.current.name, iosVersion: UIDevice.current.systemVersion)
        
        params["device"] = device.toJson()
        
        
        let updateUserDevice = EVUserServices.shareInstance.updateDeviceInfo(with: params)
        _ = updateUserDevice.subscribe(onNext: { (result) in
            log.info("Update device info: ")
            log.info(result)
        }, onError: { (error) in
            log.error(error)
        })
    }
    
}
