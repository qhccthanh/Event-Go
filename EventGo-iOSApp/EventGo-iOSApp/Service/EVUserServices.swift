//
//  EVUserServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/31/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//
import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa
import enum Result.NoError

public class EVUserServices: BaseService {
    
    static let shareInstance = EVUserServices()
    
    override var subUrl: String{
        return "users"
    }
    
    func login(with token: String, type: String, idUser: String?)-> RACSignal<AnyObject> {
        
        var params = Dictionary<String, Any>()
        params["provider_type"] = type
        params["provider_access_token"] = token
        if let idUser = idUser {
        params["provider_id"] = idUser
        }
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_POST, header: self.headers, urlString: self.path, params: params).subscribeNext({ (object) in
                // Co the la NSDictionary kiem tra ky
                sub.sendNext(object)
            }, error: { (error) in
                
                sub.sendError(error)
            })
            return nil
        })
    }
        
}
