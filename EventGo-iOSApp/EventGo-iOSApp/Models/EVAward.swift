//
//  EVAward.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class EVAward: Object {

    dynamic var award_id: String!
    dynamic var event_id: String!
    dynamic var supplier_id: String?
    dynamic var name: String!
    dynamic var detail: String!
    dynamic var image_url: String?
    dynamic var type: String?
    dynamic var contact: String?
    dynamic var item_id: String?
    dynamic var created_date: Double = 0
    dynamic var status: String?
    dynamic var priority: Int = 0
//    dynamic var location_info: NSDictionary?
    
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
        
        let award = EVAward()
        award.award_id = data["_id"].stringValue
        award.event_id = data["event_id"].stringValue
        
        award.supplier_id = data["supplier_id"].stringValue
        award.name = data["name"].stringValue
        award.detail = data["detail"].stringValue
        award.image_url = data["image_url"].stringValue
        award.type = data["award_type"].stringValue
        award.contact = data["contact"].stringValue
        award.item_id = data["item_id"].stringValue
        award.created_date = data["created_date"].doubleValue
        award.priority = data["priority"].intValue
        award.status = data["status"].stringValue
        
        return award
    }
    
    class func fromArrayJson(data: JSON) -> [EVAward] {
        
        var arrayAward:[EVAward] = [EVAward]()
        
        let arrayValues = data["data"].arrayValue
        for value in arrayValues {
            let award = fromJson(data: value)
            arrayAward.append(award)
        }
        return arrayAward
    }
}
