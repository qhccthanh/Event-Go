//
//  EVTask.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift

class EVTask: Object {

    dynamic var task_id: String!
    dynamic var supplier_id: String!
    dynamic var name: String!
    dynamic var sub_name: String!
    dynamic var thumbnail_url: String?
    dynamic var cover_url: String?
    dynamic var policy_url: String?
    dynamic var detail_url: String?
    dynamic var start_time: Double = 0
    dynamic var end_time: Double = 0
    dynamic var created_date: Double = 0
    dynamic var location_info: NSDictionary?
    dynamic var priority: Double = 1
    dynamic var limit_user: Double = 0
    dynamic var rule: NSDictionary?
    dynamic var status: String!
    
    override public static func primaryKey() -> String? {
        return "task_id"
    }
    
    class func fromJson(data: JSON) -> EVTask {
        
        var task = EVTask()
        task.task_id = data["task_id"].stringValue
        task.supplier_id = data["supplier_id"].stringValue
        task.name = data["name"].stringValue
        task.sub_name = data["sub_name"].stringValue
        task.thumbnail_url = data["thumbnail_url"].stringValue
        task.cover_url = data["cover_url"].stringValue
        task.policy_url = data["policy_url"].stringValue
        task.detail_url = data["detail_url"].stringValue
        task.start_time = data["start_time"].doubleValue
        task.end_time = data["end_time"].doubleValue
        task.created_date = data["created_date"].doubleValue
        task.location_info = data["location_info"]
        task.priority = data["priority"].doubleValue
        task.limit_user = data["limit_user"].doubleValue
        task.rule = data["rule"]
        task.status = data["status"].stringValue
        
        return task
    }
}
