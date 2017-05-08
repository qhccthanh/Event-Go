//
//  EVDevice.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/25/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import SwiftyJSON

public class EVDevice {
    
    var deviceToken: String = ""
    var model: String = ""
    var iosVersion: String = ""
    
    init(model: String, iosVersion: String){
        self.model = model
        self.iosVersion = iosVersion
    }
    
    init() {}
    
    func toJson() -> Dictionary<String, String>{
        var dictionary = Dictionary<String,String>()
        dictionary["device_token"] = self.deviceToken
        dictionary["model"] = self.model
        dictionary["os"] = self.iosVersion
        return dictionary
    }
    
    class func fromJson(data: JSON) -> EVDevice {
        
        let device: EVDevice = EVDevice()
        device.model = data["model"].stringValue
        device.iosVersion = data["os"].stringValue
        return device
    }
}
