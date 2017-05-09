//
//  EVUserAward.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/9/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

import RealmSwift
import SwiftyJSON

class EVUserAward: Object {

    dynamic var id: String!
    dynamic var event_id: String!
    dynamic var user_id: String!
    dynamic var task_id: String!
    dynamic var award_id: String!
    dynamic var supplier_id: String!
    dynamic var status: String!
    dynamic var create_time: NSDate = NSDate()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    class func fromJson(data: JSON) -> EVUserAward {
        
        let userAward = EVUserAward().build {
            $0.id = data["_id"].stringValue
            $0.event_id = data["event_id"].stringValue
            $0.user_id = data["user_id"].stringValue
            $0.task_id = data["task_id"].stringValue
            $0.award_id = data["award_id"].stringValue
            $0.supplier_id = data["supplier_id"].stringValue
            
            $0.status = data["status"].stringValue
            $0.create_time = data["create_time"].stringValue.toISODate() as NSDate
        }
        
        return userAward
    }

    
}
