//
//  EVUserInfo.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/31/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
class EVUserInfo: NSObject {
    
    static let shareInstance = EVUserInfo()
    
    open func setTokenFB(_ token: String) {
        if !token.isEmpty {
            UserDefaults.standard.setValue(token, forKey: "tokenFB")
        } else {
            return
        }
    }
    open func getTokenFB()-> String {
        return UserDefaults.standard.string(forKey: "tokenFB") ?? ""
    }
    
    internal func clearTokenFB() {
        UserDefaults.standard.setValue("", forKey: "tokenFB")
    }
    
    open func setToken(_ token: String) {
        if !token.isEmpty {
            UserDefaults.standard.setValue(token, forKey: "token")
        } else {
            return
        }
    }
    open func getToken()-> String {
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    open func clearToken(){
        UserDefaults.standard.setValue("", forKey: "token")
    }
  
    
    
}
