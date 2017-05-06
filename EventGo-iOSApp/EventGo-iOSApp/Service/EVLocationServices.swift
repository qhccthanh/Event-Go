//
//  EVLocationServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

class EVLocationServices: BaseService {
    
    static let shareInstance = EVLocationServices()
    
    override var subUrl: String{
        return "locations"
    }
    
    func getDetailLocation(with idLocation: String)-> RACSignal<AnyObject> {
        let url = path + "\(idLocation)"
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: url, params: nil).subscribeNext({ (object) in
                sub.sendNext(object)
            }, error: { (error) in
                sub.sendError(error)
            })
            return nil
        })
    }
    
}
