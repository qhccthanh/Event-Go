//
//  EVNotification.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class EVNotification: Object {

    dynamic var id: String!
    dynamic var title: String!
    dynamic var body: String!
    dynamic var image_url: String?
    dynamic var create_time: NSDate!
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    class func fromJson(data: JSON) -> EVNotification {
        
        let notification = EVNotification()
        notification.id = data["_id"].stringValue
        notification.title = data["title"].stringValue
        notification.body = data["body"].stringValue
        notification.image_url = data["image_url"].stringValue
        notification.create_time = data["create_time"].stringValue.toISODate() as NSDate
        
        return notification
    }

}
