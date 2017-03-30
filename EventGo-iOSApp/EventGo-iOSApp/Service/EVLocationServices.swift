//
//  EVLocationServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
public class EVLocationServices {
    
    static let shareInstance = EVLocationServices()
    
    var path: String{
        return "locations"
    }
    
    var headers: [String : String] {
        return ["Content-Type": "application/json", "token": ""]
    }
    
    func getDetailLocation(with idLocation: String)-> RACSignal<AnyObject> {
        let subPath = "\(idLocation)"
        
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
