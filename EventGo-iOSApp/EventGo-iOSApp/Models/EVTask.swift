//
//  EVTask.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class EVTask: Object {

    dynamic var task_id: String!
    dynamic var supplier_id: String!
    dynamic var event_id: String!
    dynamic var thumbnail_url: String?
    dynamic var task_type: String!
    dynamic var task_info: EVLocation! = EVLocation()
    dynamic var status: String!
    dynamic var descriptionTask: String!
    dynamic var name: String!
    dynamic var sub_name: String!
    dynamic var created_date: String = ""

//    dynamic var cover_url: String?
//    dynamic var policy_url: String?
//    dynamic var detail_url: String?
//    dynamic var end_time: Double = 0
//    dynamic var created_date: Double = 0
////    dynamic var location_info: NSDictionary?
//    dynamic var priority: Double = 1
//    dynamic var limit_user: Double = 0

    
    override public static func primaryKey() -> String? {
        return "task_id"
    }
    
    class func fromJson(data: JSON) -> EVTask {
        
        let task = EVTask()
        task.task_id = data["_id"].stringValue
        task.event_id = data["event_id"].stringValue
        task.supplier_id = data["supplier_id"].stringValue
        task.thumbnail_url = data["thumbnail_url"].stringValue
        task.task_type = data["task_type"].stringValue
        task.task_info = EVLocation.fromJson(data: data["task_info"])
        task.name = data["name"].stringValue
        task.sub_name = data["sub_name"].stringValue
        task.status = data["status"].stringValue
        task.descriptionTask = data["description"].stringValue
        task.created_date = data["created_date"].stringValue

        return task
    }
    
    class func listFromJson(data: JSON) ->[EVTask] {
        var listTasks: [EVTask] = [EVTask]()
        let arrayData = data.arrayValue
        for item in arrayData {
            listTasks.append(EVTask.fromJson(data: item))
        }
        return listTasks
    }
}
