//
//  EVUser.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

public class EVUser: Object {

    var name: String!
    var nick_name: String?
    var gender: String?
    var image_url: String?
    var created_date: Double = 0
    var provider_type: String?
    var provider_id: String?
    var provider_access_token: String?
    var age: Int?
    var birthday: Double = 0
    var address: String?
    var level: Int?
    var user_status: String?
    var tags: List<EVString>?
    var tags_str:[String] {
        get {
            guard let array = self.tags else {
                return []
            }
            return EVString.toArray(array)
        }
    }
  
    
    class func fromJson(data: JSON) -> EVUser {
        
        let user = EVUser()
        user.name = data["name"].stringValue
        user.nick_name = data["nick_name"].stringValue
        user.image_url = data["image_url"].stringValue
        user.created_date = data["created_date"].doubleValue
        user.provider_type = data["provider_type"].stringValue
        user.provider_access_token = data["access_token"].stringValue
        user.gender = data["gender"].stringValue
        user.birthday = data["birthday"].doubleValue
        user.address = data["address"].stringValue
        user.level = data["level"].intValue
        user.user_status = data["user_status"].stringValue
        return user
    }
}
