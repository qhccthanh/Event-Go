//
//  EVAward.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift

class EVAward: Object {

    dynamic var award_id: String!
    dynamic var supplier_id: String?
    dynamic var name: String!
    dynamic var detail: String!
    dynamic var image_url: String?
    dynamic var more: String?
    dynamic var contact: String?
    dynamic var item_id: String?
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
        return "award_id"
    }
    
    class func fromJson(data: JSON) -> EVAward {
        
        var award = EVAward()
        award.award_id = data["award_id"].stringValue
        award.supplier_id = data["supplier_id"].stringValue
        award.name = data["name"].stringValue
        award.detail = data["detail"].stringValue
        award.image_url = data["image_url"].stringValue
        award.more = data["more"].stringValue
        award.contact = data["contact"].stringValue
        award.item_id = data["item_id"].stringValue
        award.created_date = data["created_date"].doubleValue
        award.location_info = data["location_info"]
        award.status = data["status"].stringValue
        
        return award
    }
}
