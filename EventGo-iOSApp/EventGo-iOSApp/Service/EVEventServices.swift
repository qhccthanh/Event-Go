//
//  EVEventServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa
import enum Result.NoError

public class EVEventServices: BaseService {
    
    static let shareInstance = EVEventServices()
    
    override var subUrl: String{
        return "events"
    }
 
    
    func getDetailEvent(with id: String)-> RACSignal<AnyObject> {
        let url = path + "\(id)"
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            let networkRequest = EVReactNetwork()
            networkRequest.request(withMethod: "get", header: self.headers, urlString: url, params: nil, body: nil).subscribeNext({ (object) in
                    sub.sendNext(object)
            }, error: { (error) in
                sub.sendError(error)
            })
            return nil
        })
    }
    

    
}
