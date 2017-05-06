//
//  NSError+Extension.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/6/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

extension NSError {
    
    class func defaultAPIError() -> NSError {
        return NSError(domain: "com.eventGo", code: 5, userInfo: [NSLocalizedDescriptionKey: "api error"])
    }
    
}
