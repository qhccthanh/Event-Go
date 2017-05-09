//
//  EVUserTask.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/9/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

import RealmSwift
import SwiftyJSON

class EVTaskResult: Object {
    
    dynamic var post_id: String?
    dynamic var image_url: String?
    dynamic var note: String?
    
    class func fromJson(data: JSON) -> EVTaskResult {
        return EVTaskResult().build({
            $0.post_id = data["post_id"].stringValue
            $0.image_url = data["image_url"].stringValue
            $0.note = data["note"].stringValue
        })
    }
}

class EVUserTask: Object {
    
    dynamic var id: String!
    dynamic var event_id: String!
    dynamic var user_id: String!
    dynamic var task_id: String!
    dynamic var user_event_id: String!
    dynamic var status: String!
    dynamic var start_time: NSDate = NSDate()
    dynamic var end_time: NSDate = NSDate()
    dynamic var result: EVTaskResult?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    class func fromJson(data: JSON) -> EVUserTask {
        
        let userTask = EVUserTask().build {
            $0.id = data["_id"].stringValue
            $0.event_id = data["event_id"].stringValue
            $0.user_id = data["user_id"].stringValue
            $0.task_id = data["task_id"].stringValue
            $0.user_event_id = data["user_event_id"].stringValue
            $0.status = data["status"].stringValue
            $0.start_time = data["start_time"].stringValue.toISODate() as NSDate
            $0.end_time = data["end_time"].stringValue.toISODate() as NSDate
            $0.result = EVTaskResult.fromJson(data: data["result"])
        }
        
        return userTask
    }
}
