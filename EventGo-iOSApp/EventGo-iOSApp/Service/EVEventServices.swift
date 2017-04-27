//
//  EVEventServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit




public class EVEventServices: BaseService {
    
    static let shareInstance = EVEventServices()
    
    override var subUrl: String{
        return "events"
    }
 
    
    func getDetailEvent(with id: String)-> RACSignal<AnyObject> {
        let url = path + "\(id)"
        
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
