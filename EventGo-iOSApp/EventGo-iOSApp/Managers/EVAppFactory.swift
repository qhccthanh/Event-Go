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
    
    static var users: EVAppFactoryUsers = EVAppFactoryUsers()
    static var client: EVAppFactoryClient = EVAppFactoryClient()
    
    public var currentUser: EVUser?
    
    private override init() {
        super.init()
        
    }
    
}

