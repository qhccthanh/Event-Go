//
//  EVEvent.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

public class EVEvent: Object {

    dynamic var event_id: String!
    dynamic var supplier_id: String!
    dynamic var name: String!
    dynamic var sub_name: String!
    dynamic var thumbnail_url: String?
    dynamic var cover_url: String?
    dynamic var policy_url: String?
    dynamic var detail_url: String?
    dynamic var start_time: Date?
    dynamic var end_time: Date?
    dynamic var supplierName: String! = ""
    dynamic var created_date: Double = 0
//    dynamic var location_info: NSDictionary?
    dynamic var priority: Double = 1
    dynamic var limit_user: Double = 0
//    dynamic var rule: NSDictionary?
    dynamic var status: String!
    var award_ids: List<EVString>?
    var task_ids: List<EVString>?
    var tags: List<EVString>?
    
    var awards: List<EVAward>?
    var tasks: List<EVTask>?
    
    var tags_str: [String] {
        get {
            guard let array = self.tags else {
                return []
            }
            
            return EVString.toArray(array)
        }
    }
    
    override public static func primaryKey() -> String? {
        return "event_id"
    }
    
    class func fromJson(data: JSON) -> EVEvent {
        
        let event = EVEvent()
        event.event_id = data["event_id"].stringValue
//        event.supplier_id = data["supplier_id"].stringValue
        event.supplierName = data["supplier_id"]["name"].stringValue
        event.name = data["name"].stringValue
        event.sub_name = data["sub_name"].stringValue
        event.thumbnail_url = data["thumbnail_url"].stringValue
        event.cover_url = data["cover_url"].stringValue
        event.policy_url = data["policy_url"].stringValue
        event.detail_url = data["detail_url"].stringValue
        event.start_time = Date.fromStringDate(data["start_time"].stringValue)
        event.end_time = Date.fromStringDate(data["end_time"].stringValue) 
        event.created_date = data["created_date"].doubleValue
//        event.location_info = data["location_info"].dictionaryObject as NSDictionary?
        event.priority = data["priority"].doubleValue
        event.limit_user = data["limit_user"].doubleValue
//        event.rule = data["rule"].dictionaryObject as NSDictionary?
        event.status = data["status"].stringValue
        event.tags = EVString.fromJson(data: data["tags"])
        return event
    }
    
    class func listFromJson(data: JSON) -> [EVEvent] {
        var listEvent = [EVEvent]()
        let arrayValues = data["data"].arrayValue
        for value in arrayValues {
          listEvent.append(fromJson(data: value))
        }
        
        return listEvent
    }
}

