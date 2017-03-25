//
//  EVLog.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 3/22/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import XCGLogger

let log: XCGLogger = {
    let log = XCGLogger(identifier: "advancedLogger", includeDefaultDestinations: false)
    
    #if DEBUG
        log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true)
    #else
        log.setup(level: .severe, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true)
    #endif
    
    // Create a destination for the system console log (via NSLog)
    let systemDestination = AppleSystemLogDestination(identifier: "evLogger.systemDestination")
    // Optionally set some configuration options
    systemDestination.outputLevel = .debug
    systemDestination.showLogIdentifier = false
    systemDestination.showFunctionName = true
    systemDestination.showThreadName = true
    systemDestination.showLevel = true
    systemDestination.showFileName = true
    systemDestination.showLineNumber = true
    systemDestination.showDate = true
    
    // Add the destination to the logger
    log.add(destination: systemDestination)
    
    // Create a file log destination
    let fileDestination = FileDestination(writeToFile: "/path/to/file", identifier: "advancedLogger.fileDestination")
    
    // Optionally set some configuration options
    fileDestination.outputLevel = .debug
    fileDestination.showLogIdentifier = false
    fileDestination.showFunctionName = true
    fileDestination.showThreadName = true
    fileDestination.showLevel = true
    fileDestination.showFileName = true
    fileDestination.showLineNumber = true
    fileDestination.showDate = true
    
    // Process this destination in the background
    fileDestination.logQueue = XCGLogger.logQueue
    
    // Add the destination to the logger
    log.add(destination: fileDestination)
    
    // Add basic app info, version info etc, to the start of the logs
    log.logAppDetails()
    
    return log
}()
