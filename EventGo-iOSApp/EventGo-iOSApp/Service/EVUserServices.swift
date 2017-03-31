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
    
    func loginWithFB(with tokenFB: String)-> RACSignal<AnyObject> {
        
        var params = Dictionary<String, Any>()
        params["provider_type"] = "facebook"
        params["provider_access_token"] = tokenFB
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_POST, header: self.headers, urlString: self.path, params: params).subscribeNext({ (object) in
                // Co the la NSDictionary kiem tra ky
                print(object)
                sub.sendNext(object)
            }, error: { (error) in
                
                sub.sendError(error)
            })
            return nil
        })
    }
    
    func getDetailTaskOfEvent(with idTask: String)-> RACSignal<AnyObject> {
        let subPath = "\(idTask)"
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: subPath, params: nil).subscribeNext({ (object) in
                sub.sendNext(object)
            }, error: { (error) in
                sub.sendError(error)
            })
            return nil
        })
    }
    
}
