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
    
    
}

