//
//  EVAwardServices.swift
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

public class EVAwardServices: BaseService {
    
    static let shareInstance = EVAwardServices()
    
    override var subUrl: String{
        return "awards"
    }
 
    func getDetailAward(with idAward: String)-> RACSignal<AnyObject> {
        let subPath = "/\(idAward)"
        
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