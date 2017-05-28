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
    
    func getAllTask(_ idEvent: String, userId: String) -> Observable<[EVTask]> {
        
        
        return Observable.create({ (sub) -> Disposable in
            
            dispatch_main_queue_safe {
//                let tasks: [EVTask] = evRealm().read()
//                sub.onNext(tasks)
            }
            
            let request = EVTaskServices.getAllTasks(idEvent, userId: userId)
                .observeOn(MainScheduler.instance).subscribe(onNext: { (tasks) in
//                    tasks.save()
                    sub.onNext(tasks)
                }, onError: { (error) in
                    sub.onError(error)
                })
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    func joinTask(_ task: EVTask, idEvent: String) -> Observable<EVResponseMission> {
        return EVAppFactoryClient.requestMission(EVClientUserService.joinTask(task.task_id, eventId: idEvent))
    }
    
    func getMyTasks() -> Observable<[EVUserTask]>{
        return Observable.create({ (sub) -> Disposable in
            
            dispatch_main_queue_safe {
                let userEvent: [EVUserTask] = evRealm().read()
                sub.onNext(userEvent)
            }
            let request = EVClientUserService.getAllMyTasks().observeOn(MainScheduler.instance).subscribe(onNext: { (dataJson) in
                if dataJson["code"] == 200 {
                    let listTasks = EVUserTask.listFromJson(data: dataJson["data"])
                    sub.onNext(listTasks)
                } else {
                    sub.onError("Không parse dc data".toError())
                }

                
            }, onError: { (error) in
                sub.onError(error)
            })
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    func completeTask(_ task: EVTask, userEventId: String, linkPost: String, imageURL: String, location: CLLocationCoordinate2D) -> Observable<EVResponseMission> {
        return EVAppFactoryClient.requestMission(EVClientUserService
            .completeTask(userEventId, task.task_id,
                          params: [
                            "result": [
                                "link_post": linkPost,
                                "image_url": imageURL,
                                "lat": location.latitude,
                                "lng": location.longitude
                            ]
                ]))
    }
    
    func outTask(_ task: EVTask) -> Observable<EVResponseMission> {
        return EVAppFactoryClient.requestMission(EVClientUserService.outTask(task.task_id))
    }
    
    func uploadImage(image: UIImage, supplierId: String) -> Observable<String> {
        let tempImage = EVImageResource(name: "upload", image: image)
        
        return Observable.create({ (sub) -> Disposable in
            let request = EVTaskServices.uploadImage(imageStore: tempImage, supplierId: supplierId).subscribe(onNext: { (image_url) in
                
                sub.onNext(image_url)
            }, onError: { (error) in
                sub.onError(error)
            })
            return Disposables.create {
                request.dispose()
            }
        })
    }
}
