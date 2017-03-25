//
//  EVSupplier.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift


class EVSupplier: Object {

    dynamic var supplier_id: String!
    dynamic var name: String!
    dynamic var image_url: String?
    dynamic var level: Int = 1
    dynamic var company_info: NSDictionary?
    dynamic var status: String!
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
        return "supplier_id"
    }
}
