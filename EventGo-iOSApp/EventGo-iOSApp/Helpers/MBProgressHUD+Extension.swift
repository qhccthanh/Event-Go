//
//  MBProgressHUD+Extension.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/6/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import MBProgressHUD

extension MBProgressHUD {
    
    class func showHUDLoading(_ view: UIView = UIApplication.shared.keyWindow!) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
//        hud.label.text = "Đang xữ lý vui lòng chờ ..."
        hud.mode = .indeterminate
    }
    
    class func hideHUDLoading(_ view: UIView = UIApplication.shared.keyWindow!) {
        MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
    }
    
}

