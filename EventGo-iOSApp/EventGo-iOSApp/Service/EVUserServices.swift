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
import SwiftyJSON
import enum Result.NoError

public class EVUserServices: BaseService {
    
    static let shareInstance = EVUserServices()
    
    override var subUrl: String{
        return "users"
    }
    
    func checkInfoUser() -> RACSignal<NSDictionary>{
        
        let url = path + "/me"
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: url, params: nil).subscribeNext({ (result) in
                if let result = result as? NSDictionary {
                    sub.sendNext(result)
                } else {
                    sub.sendError("Lỗi không parse được data" as? Error)
                }

            }, error: { (error) in
                log.error(error)
            })
            return nil
        })
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
                let dataJSon = JSON(object!)
                if dataJSon["code"] == 200 {
                    let user = EVUser.fromJson(data: dataJSon["data"])
                    sub.sendNext(user)
                }
            }, error: { (error) in
                
                sub.sendError(error)
            })
            return nil
        })
    }
    
    func login(with params: Dictionary<String, Any>)-> RACSignal<NSDictionary> {

        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
                EVReactNetwork.request(with: EVReactNetworkMethod_POST, header: self.headers, urlString: self.path, params: params).subscribeNext({ (object) in
                    if let object = object as? NSDictionary {
                        
                        sub.sendNext(object)
                    } else {
                        
                        sub.sendError("Lỗi không parse được data" as? Error)
                    }
                }, error: { (error) in
                    
                    sub.sendError(error)
                })
            
            return nil
        })
    }

        
}
