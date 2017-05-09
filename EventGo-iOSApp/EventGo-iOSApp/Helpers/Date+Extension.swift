//
//  Date+Extension.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/6/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

extension Date {
    
    static fileprivate var js_StringFormart: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter
    }()
    
    static func fromStringDate(_ string: String) -> Date {
        
        let dateFormatter = Date.js_StringFormart
        let date = dateFormatter.date(from: string)!
        
        return date
    }
}

extension String {
    
    func toISODate() -> Date {
        return self == "" ? Date() : Date.fromStringDate(self)
    }
}
