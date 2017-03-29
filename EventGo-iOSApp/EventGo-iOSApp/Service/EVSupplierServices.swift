//
//  EVSupplierServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/29/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa
import enum Result.NoError

public class EVSupplierServices {
    
    static let shareInstance = EVSupplierServices()
    
    var path: String{
        return "suppliers"
    }
    
     var headers: [String : String] {
        return ["Content-Type": "application/json", "token": ""]
    }

    func getAllSupplier()-> RACSignal<AnyObject> {
        
            return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVNetworkManager.sharedInstance().request(withPath: self.path, parameters: nil).subscribeNext({ (object) in
                sub.sendNext(object)
            }, error: { (error) in
                sub.sendError(error)
            })
            return nil
        })
    }

    func getAllEventsOfSupplier( with idSupplier: Int) -> RACSignal<AnyObject> {
        
        let subPath = path + "\(idSupplier)/events"
        
        return RACSignal.createSignal({ (subcrible) -> RACDisposable? in
            EVNetworkManager.sharedInstance().request(withPath: subPath, parameters: nil).subscribeNext({ (object) in
                subcrible.sendNext(object)
            }, error: { (error) in
                subcrible.sendError(error)
            })
        })
    }
    
    func getAllItemsOfSupplier( with idSupplier: Int) -> RACSignal<AnyObject> {
        
        let subPath = path + "\(idSupplier)/items"
        
        return RACSignal.createSignal({ (subcrible) -> RACDisposable? in
            EVNetworkManager.sharedInstance().request(withPath: subPath, parameters: nil).subscribeNext({ (object) in
                subcrible.sendNext(object)
            }, error: { (error) in
                subcrible.sendError(error)
            })
        })
    }
    
    func getAllAwardsOfSupplier( with idSupplier: Int) -> RACSignal<AnyObject> {
        
        let subPath = path + "\(idSupplier)/awards"
        
        return RACSignal.createSignal({ (subcrible) -> RACDisposable? in
            EVNetworkManager.sharedInstance().request(withPath: subPath, parameters: nil).subscribeNext({ (object) in
                subcrible.sendNext(object)
            }, error: { (error) in
                subcrible.sendError(error)
            })
        })
    }
    
    func getAllNotificationsOfSupplier( with idSupplier: Int) -> RACSignal<AnyObject> {
        
        let subPath = path + "\(idSupplier)/notifications"
        
        return RACSignal.createSignal({ (subcrible) -> RACDisposable? in
            EVNetworkManager.sharedInstance().request(withPath: subPath, parameters: nil).subscribeNext({ (object) in
                subcrible.sendNext(object)
            }, error: { (error) in
                subcrible.sendError(error)
            })
        })
    }
    
}
