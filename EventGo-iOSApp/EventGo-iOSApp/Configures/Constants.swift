//
//  Constants.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/22/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation


struct EVConstant {
    
    static let version: String = "1.0"
    static let API_GOOGLE_MAP_KEY: String = ""
    static let API_GOOGLE_PLACE_KEY: String = ""
    static let BASE_URL_STRING: String = ""
    static let BASE_URL: URL = URL(string: EVConstant.BASE_URL_STRING)!
    static let isDebug: Bool = false
}

let ONCE_DAY_INTERVAL: TimeInterval = 24 * 60 * 60
