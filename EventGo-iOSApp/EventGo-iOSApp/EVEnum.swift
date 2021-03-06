//
//  EVEnum.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/10/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
enum EVCheckUserEnumType: String {
    case login
    case notLogin
    case updatedInfo
}

enum EVTaskStatus: String {
    case pending,finished,ready
    
    func name() -> String{
        return self.rawValue
    }
}

enum EVUserTaskStatus: String {
    case doing, cancel, completed
    
    func name() -> String {
        return self.rawValue
    }
}

enum EVEventStatus: String {
    case preparing,stagging,expired
    
    func name() -> String{
        return self.rawValue
    }
}

enum EVUpdateResult: String {
    case success
    case faillure
}

enum EVImage: String {
    
    case backgroundColor = "backgroundColor"
    case ic_distance = "ic_distance"
    case ic_email = "ic_email"
    case ic_facebook = "ic_facebook"
    case ic_google = "ic_google"
    case ic_pagoda = "ic_pagoda"
    case ic_phone = "ic_phone"
    case ic_quit = "ic_quit"
    case ic_user = "ic_user"
    case ic_logo = "ic_logo"
    case ic_back = "ic_back"
    case ic_check = "ic_check"
    case ic_gift = "ic_gift"
    case ic_checklist = "ic_checklist"
    case ic_bag = "ic_bag"
    case ic_package = "ic_package"
    case ic_run = "ic_run"
    case ic_startTime = "ic_startTime"
    case ic_event = "ic_event"
    case ic_app_3d = "appIcon_3d"
    case ic_placeholder = "ic_placeholder"
    case ic_bsmart = "ic_bsmart"
    case ic_circle = "ic_circle"
}

extension EVImage {
    
    func icon() -> UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    func name() -> String {
        return self.rawValue
    }
}

enum EVController: String {

    case viewController = "EVViewController"
    case logIn = "EVLogInViewController"
    case mainGame = "EVMainGameController"
    case defaultVC = "EVDefaultViewController"
    case userInfo = "EVUpdateUserInfoViewController"
    case popOver = "EVPopOverController"
    case home = "EVHomeViewController"
    case infoTask = "EVInfoTaskViewController"
    case detailEvent = "EVDetailEventViewController"
    case listAwards = "EVListAwardsViewController"
    case listEvents = "EVListEventsViewController"
    case infoAwards = "EVInfoAwardViewController"
    case events = "EVEventsViewController"
    case tasks = "EVTasksViewController"
    case completeTask = "EVCompleteTaskViewController"
    case userEvents = "EVListUserEventsViewController"
}
extension EVController {
    
    func getController() -> EVViewController {
        let controller = StoryBoard.EventGo.viewController(self.rawValue)
        return controller as! EVViewController
    }
    
    func showController(_ inController: UIViewController? = nil) {
        dispatch_main_queue_safe {
            let vc = self.getController()
            guard let inController = inController else {
                UIApplication.shared.keyWindow?.rootViewController = vc
                return
            }
            inController.present(vc, animated: true, completion: nil)
        }
    }
}
