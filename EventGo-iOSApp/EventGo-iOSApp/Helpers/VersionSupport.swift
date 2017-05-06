//
//  VersionSupport.swift
//  TFDictionary
//
//  Created by Quach Ha Chan Thanh on 7/30/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

import Foundation

func SYSTEM_VERSION_EQUAL_TO(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                          options: NSString.CompareOptions.numeric) == ComparisonResult.orderedSame
}

func SYSTEM_VERSION_GREATER_THAN(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                          options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending
}

func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                          options: NSString.CompareOptions.numeric) != ComparisonResult.orderedAscending
}

func SYSTEM_VERSION_LESS_THAN(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                          options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
}

func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                          options: NSString.CompareOptions.numeric) != ComparisonResult.orderedDescending
}
