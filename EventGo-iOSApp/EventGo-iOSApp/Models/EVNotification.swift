//
//  EVNotification.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift

class EVNotification: Object {

    dynamic var notification_id: String!
    dynamic var supplier_id: String!
    dynamic var title: String!
    dynamic var body: String!
    dynamic var image_url: String?
    dynamic var time_start_push: String?
    dynamic var time_end_push: String?
    dynamic var max_push_per_user: String?
    dynamic var max_user_push: Double = 0
    dynamic var status: String?
    
    var tags: List<EVString>?
    var tags_str:[String] {
        get {
            guard let array = self.tags else {
                return []
            }
            return EVString.toArray(array)
        }
    }
    
    override public static func primaryKey() -> String? {
        return "notification_id"
    }
    
    class func fromJson(data: JSON) -> EVTask {
        
        var notification = EVNotification()
        notification.notification_id = data["notification_id"].stringValue
        notification.supplier_id = data["supplier_id"].stringValue
        notification.title = data["title"].stringValue
        notification.body = data["body"].stringValue
        notification.image_url = data["image_url"].stringValue
        notification.time_start_push = data["time_start_push"].stringValue
        notification.time_end_push = data["time_end_push"].stringValue
        notification.max_push_per_user = data["max_push_per_user"].stringValue
        notification.max_user_push = data["max_user_push"].doubleValue
        notification.status = data["status"].stringValue
        
        return notification
    }

}
