//
//  EVTaskServices.swift
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

public class EVTaskServices {
    
    static let shareInstance = EVTaskServices()
    
    var path: String{
        return "events"
    }
    
    var headers: [String : String] {
        return ["Content-Type": "application/json", "token": ""]
    }
    
    func getAllTaskOfEvent(with idEvent: String)-> RACSignal<AnyObject> {
        let subPath = "\(idEvent)"
        
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
