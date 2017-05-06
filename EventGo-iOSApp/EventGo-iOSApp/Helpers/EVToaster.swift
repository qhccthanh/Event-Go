//
//  Toaster+Extension.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/6/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import Toaster

class EVToaster {
    
    static var toast: Toast!
    
    class func show(_ mesage: String, duration: TimeInterval = Delay.short) {
        if toast != nil {
            toast.cancel()
        }
        toast = Toast.init(text: mesage, duration: duration)
        toast.show()
    }
}
