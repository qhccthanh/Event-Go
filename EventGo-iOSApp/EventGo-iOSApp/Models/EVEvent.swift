//
//  EVEvent.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift

public class EVEvent: Object {

    dynamic var event_id: String!
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
}
