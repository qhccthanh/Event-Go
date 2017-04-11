//
//  EVClientService.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/11/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
public class EVClientService: BaseService {
    
    static let shareInstance = EVClientService()
    
    override var subUrl: String{
        return "locations"
    }
    
    
    func getDetailItem(with idItem: String)-> RACSignal<AnyObject> {
        let url = path + "\(idItem)"
        
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
