//
//  Realm+Extension.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    func write(_ object: Object, update: Bool = true) -> RACSignal<AnyObject> {
        
        return RACSignal.createSignal { (subscribe) -> RACDisposable? in
            
            do {
                try self.write {
                    self.add(object, update: update)
                    subscribe.sendNext(object)
                }
            } catch {
                subscribe.sendError(nil)
            }
            
            return nil
        }
    }
    
    func write(_ object: Object, update: Bool = true)  {
        
        do {
            try self.write {
                self.add(object, update: update)
            }
        } catch {
            print("Write object fail")
        }
    }
    
    func write(_ objects: [Object], update: Bool = true) -> RACSignal<AnyObject> {
        
        return RACSignal.createSignal { (subscribe) -> RACDisposable? in
            
            do {
                try self.write {
                    self.add(objects, update: update)
                    subscribe.sendNext(objects)
                }
            } catch {
                subscribe.sendError(nil)
            }
            
            return nil
        }
    }
    
    func write(_ objects: [Object], update: Bool = true)  {
        
        do {
            try self.write {
                self.add(objects, update: update)
            }
        } catch {
            print("Write object fail")
        }
    }
    
    func filter<T: Object>(_ conditions: String) -> [T] {
        return self.objects(T.self).filter(conditions).map({ (value) -> T in
            return value
        })
    }
    
    func read<T: Object>() -> [T] {
        
        var arrayT = [T]()
        self.objects(T.self).forEach { (value) in
            arrayT.append(value)
        }
        
        return arrayT
    }
}
