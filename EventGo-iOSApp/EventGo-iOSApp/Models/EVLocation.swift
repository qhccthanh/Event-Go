//
//  EVLocation.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift

class EVLocation: Object {

    dynamic var location_id: String!
    dynamic var supplier_id: String!
    dynamic var name: String?
    dynamic var detail: String
    dynamic var address: String?
    dynamic var image_url: String?
    dynamic var created_date: Double = 0
    dynamic var location_info: Dictionary
    var tags: List<EVString>?
    dynamic var status: String?
    
    var tags_str:[String] {
        get {
            guard let array = self.tags else {
                return []
            }
            return EVString.toArray(array)
        }
    }
    var links: List<EVString>?
    
    var links_str: [String] {
        get {
            guard let array = self.links else {
                return []
            }
            
            return EVString.toArray(array)
        }
    }
    
    override public static func primaryKey() -> String? {
        return "location_id"
    }
    
    class func fromJson(data: JSON) -> EVLocation {
        
        var location = EVLocation()
        location.location_id = data["location_id"].stringValue
        location.supplier_id = data["supplier_id"].stringValue
        location.name = data["name"].stringValue
        location.detail = data["detail"].stringValue
        location.address = data["address"].stringValue
        location.image_url = data["image_url"].stringValue
        location.created_date = data["created_date"].doubleValue
        location.location_info = data["location_info"]
        location.status = data["status"].stringValue
        
        return location
    }
    
    
}
