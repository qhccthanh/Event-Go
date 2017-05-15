//
//  EVLocation.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/21/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class EVInfoLocation {
    var placeId: String = ""
    var formattedAddress: String = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    init (data: JSON){
        self.placeId = data["place_id"].stringValue
        self.formattedAddress = data["formatted_address"].stringValue
        self.coordinate = jsonToCoordinate(dataJson: data["coordinate"])
    }
    
    func jsonToCoordinate(dataJson: JSON) -> CLLocationCoordinate2D{
        var locattion = CLLocationCoordinate2D()
        locattion.latitude = dataJson["lat"].doubleValue 
        locattion.longitude = dataJson["lng"].doubleValue
        return locattion
    }
}

class EVLocation: Object {

    dynamic var location_id: String!
    dynamic var supplier_id: String!
    dynamic var name: String?
    dynamic var detail: String?
    dynamic var address: String?
    dynamic var image_url: String?
    dynamic var created_date: Double = 0
    var location_info: EVInfoLocation?
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
        let location = EVLocation()
        location.location_id = data["location_id"].stringValue
        location.supplier_id = data["supplier_id"].stringValue
        location.name = data["name"].stringValue
        location.detail = data["detail"].stringValue
        location.address = data["address"].stringValue
        location.image_url = data["image_url"].stringValue
        location.created_date = data["created_date"].doubleValue
        location.location_info = EVInfoLocation(data: data["location_info"])
        location.status = data["status"].stringValue
        location.tags = EVString.fromJson(data: data["tags"])
        location.links = EVString.fromJson(data: data["link"])
        return location
    }
    
    class func listFromJson(data: JSON) -> [EVLocation] {
        var listLocation: [EVLocation] = [EVLocation]()
        let arrayValues = data["data"].arrayValue
        for value in arrayValues {
            listLocation.append(fromJson(data: value))
        }
        return listLocation
    }
    
}
