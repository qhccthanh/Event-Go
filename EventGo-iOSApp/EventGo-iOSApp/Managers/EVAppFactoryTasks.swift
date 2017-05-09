//
//  EVAppFactoryTasks.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

import SwiftyJSON
import RxSwift
import RxCocoa

public struct EVAppFactoryTasks {
    
    func joinEvent(_ task: EVTask) -> Observable<EVResponseMission> {
        return EVAppFactoryClient.requestMission(EVClientUserService.joinTask(task.task_id))
    }
    
    func completeEvent(_ task: EVTask, linkPost: String, imageURL: String) -> Observable<EVResponseMission> {
        return EVAppFactoryClient.requestMission(EVClientUserService
            .completeTask(task.task_id,
                          params: [
                            "result": [
                                "link_post": linkPost,
                                "image_url": imageURL,
                            ]
                ]))
    }
    
    func outEvent(_ task: EVTask) -> Observable<EVResponseMission> {
        return EVAppFactoryClient.requestMission(EVClientUserService.outTask(task.task_id))
    }
    
}
