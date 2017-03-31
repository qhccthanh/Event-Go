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
            
            let networkRequest = EVReactNetwork()
            networkRequest.request(withMethod: "POST", header: self.headers, urlString: self.path, params: params, body: nil).subscribeNext({ (object) in
                
                print(object as! String)
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
            let networkRequest = EVReactNetwork()
            networkRequest.request(withMethod: "get", header: self.headers, urlString: subPath, params: nil, body: nil).subscribeNext({ (object) in
                sub.sendNext(object)
            }, error: { (error) in
                sub.sendError(error)
            })
            return nil
        })
    }
    
}
