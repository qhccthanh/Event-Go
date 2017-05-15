
//
//  EVAppFactory+Client.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/6/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

import RxSwift
import SwiftyJSON

enum EVResponseMission {
    case success
    case failure(String)
}


public struct EVAppFactoryClient {
    
    var events: EVAppFactoryEvents = EVAppFactoryEvents()
    var tasks: EVAppFactoryTasks = EVAppFactoryTasks()
    var awards: EVAppFactoryEvents = EVAppFactoryEvents()
    var notifications: EVAppFactoryEvents = EVAppFactoryEvents()
    
    func loadLocations(coordinate: CLLocationCoordinate2D) -> Observable<[EVLocation]> {
        
        return Observable.create({ (sub) -> Disposable in
            
            dispatch_main_queue_safe {
//                let locations: [EVLocation] = evRealm().read()
//                sub.onNext(locations)
            }
            
            let request = EVClientService
                .getStores(in: coordinate)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (locations) in
//                    evRealm().ev_write(locations, update: true)
                    sub.onNext(locations)
                }, onError: { (error) in
                    // xu ly loi thong bao ...
                })
            
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    static func requestMission(_ requestRx: Observable<JSON>) -> Observable<EVResponseMission> {
        
        return Observable.create({ (sub) -> Disposable in
            
            let request = requestRx
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (dataJson) in
                    if dataJson["code"] != 200 {
                        let error = "Code khong phai 200 error: \(dataJson["error"].stringValue)".toError()
                        sub.onNext(.failure("Có lỗi từ máy chủ vui lòng thử lại"))
                        log.error(error)
                        return
                    }
                    
                    sub.onNext(.success)
                }, onError: { (error) in
                    sub.onNext(.failure("Có lỗi từ máy chủ vui lòng thử lại"))
                })
            
            return Disposables.create {
                request.dispose()
            }
        })
    }
}
