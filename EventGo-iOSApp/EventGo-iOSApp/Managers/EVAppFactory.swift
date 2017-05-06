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
    
    public var currentUser: EVUser?
    public var currentEvents: [EVEvent]?
    
    private override init() {
        super.init()
        
    }
    
}

