//
//  EVItem.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class EVItem: Object {

    dynamic var item_id: String!
    dynamic var supplier_id: String!
    dynamic var name: String?
    dynamic var detail: String?
    dynamic var image_url: String!
    dynamic var created_date: Double = 0
    dynamic var status: String?
    
    var tags: List<EVString>?
    
    var tags_str: [String] {
        get {
            guard let array = self.tags else {
                return []
            }
            
            return EVString.toArray(array)
        }
    }
    
    override public static func primaryKey() -> String? {
        return "item_id"
    }
    
    class func fromJson(data: JSON) -> EVItem {
        
        var item = EVItem()
        item.item_id = data["item_id"].stringValue
        item.supplier_id = data["supplier_id"].stringValue
        item.name = data["name"].stringValue
        item.detail = data["detail"].stringValue
        item.image_url = data["image_url"].stringValue
        item.created_date = data["created_date"].doubleValue
        item.status = data["status"].stringValue
        
        return item
    }
}
