//
//  EVUserEvent.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/9/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

import RealmSwift
import SwiftyJSON

class EVUserEvent: Object {
    
    dynamic var id: String!
    dynamic var event_id: String!
    dynamic var user_id: String!
    dynamic var status: String!
    dynamic var start_time: NSDate = NSDate()
    dynamic var end_time: NSDate = NSDate()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    class func fromJson(data: JSON) -> EVUserEvent {
        
        let userEvent = EVUserEvent()
        userEvent.id = data["_id"].stringValue
        userEvent.event_id = data["event_id"].stringValue
        userEvent.user_id = data["user_id"].stringValue
        userEvent.status = data["status"].stringValue
        userEvent.start_time = data["start_time"].stringValue.toISODate() as NSDate
        if data["end_time"].stringValue != "" {
            userEvent.end_time = data["end_time"].stringValue.toISODate() as NSDate
        }
        return userEvent
    }
    
    class func listFromJson(data: JSON) -> [EVUserEvent] {
        
        var listUserEV = [EVUserEvent]()
        for item in data.arrayValue {
            listUserEV.append(EVUserEvent.fromJson(data: item))
        }
        return listUserEV
    }
}
