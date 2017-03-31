//
//  EVBaseServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//
import Foundation
import SwiftyJSON

open class BaseService {
    internal let baseURL = "https://evgo.herokuapp.com/api/v1.0/"
    internal var subUrl : String {
        get {
            return ""
        }
    }
    internal var path : String {
        get {
            return baseURL.appending(subUrl)
        }
    }
    internal var headers : [String : String] {
        get {
            return ["Content-Type": "application/json"]
        }
    }
    
}
