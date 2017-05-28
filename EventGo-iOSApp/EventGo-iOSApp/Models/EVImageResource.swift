//
//  EVImageResource.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/26/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//
import Foundation
import SwiftyJSON

class EVImageResource: NSObject {
    
    var id: String = ""
    var supplierId: String = ""
    var name: String = ""
    var detail: String = ""
    var url: String = ""
    var create: Date = Date()
    var tags: [String] = [String]()
    var image: UIImage = UIImage()
    var isChecked: Bool = false
    
    
    init(data: JSON) {
        super.init()
        
        self.id = data["_id"].stringValue
        self.supplierId = data["supplier_id"].stringValue
        self.name = data["name"].stringValue
        self.detail = data["detail"].stringValue
        
        if let dateString =  data["created_date"].string {
            self.create = Date.fromStringDate(dateString)
        }
        self.url = data["image_url"].stringValue
    }
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
}
