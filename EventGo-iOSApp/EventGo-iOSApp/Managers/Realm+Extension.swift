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
    
    func ev_write(_ object: Object, update: Bool = true)  {
        dispatch_main_queue_safe {
            do {
                try self.write {
                    self.add(object, update: update)
                }
            } catch {
                log.error("Write object fail")
            }
        }
    }
    
    
    func ev_write(_ objects: [Object], update: Bool = true)  {
        dispatch_main_queue_safe {
            do {
                try self.write {
                    self.add(objects, update: update)
                }
            } catch {
                print("Write object fail")
            }
        }
    }
    
    func filter<T: Object>(_ conditions: String) -> [T] {
        return self.objects(T.self).filter(conditions).map({ (value) -> T in
            return value
        })
    }
    
    func read<T: Object>() -> [T] {
        
        var arrayT = [T]()
        dispatch_main_queue_safe {
            self.objects(T.self).forEach { (value) in
                arrayT.append(value)
            }
        }
        return arrayT
    }
}
