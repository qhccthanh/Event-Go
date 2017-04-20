//
//  EVString.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/24/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON
public class EVString: Object {
    
    dynamic var value = ""
    
    class func fromString(_ str: String) -> EVString {
        let strT = EVString()
        strT.value = str
        
        return strT
    }
    
    class func toArray(_ list: List<EVString>) -> [String] {
        return list.map { (element) -> String in
            return element.value
        }
    }
    
    class func fromArray(_ array: [String]) -> List<EVString> {
        
        let newList = List<EVString>()
        
        array.forEach { (value) in
            newList.append(EVString(value: value))
        }
        
        return newList
    }
    
    class func fromJson(data: JSON) -> List<EVString> {
        let newList = List<EVString>()
        var arrayValues = data.arrayValue
        for value in arrayValues {
            newList.append(EVString.fromString(value.stringValue))
        }
        return newList
    }
}
