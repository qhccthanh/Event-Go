//
//  EVClientService.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/11/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

import SwiftyJSON
import RxSwift

public class EVClientService: BaseService {
    
    override class public var subUrl: String {
        return "client"
    }
    
    static func getAllEventsForClient() -> Observable<[EVEvent]> {
        let url = path + "/events"
        return Observable.create({ (sub) -> Disposable in
            let request = EVReactNetwork.ev_request(with: .get, header: self.headers, urlString: url, params: nil)
                            .observeOn(MainScheduler.instance)
                            .subscribe(onNext: { (dataJson) in
                                if dataJson["code"] != 200 {
                                    let error = "Code khong phai 200 error: \(dataJson["error"].stringValue)".toError()
                                    sub.onError(error)
                                    log.error(error)
                                    return
                                }
                                
                                let events: [EVEvent] = EVEvent.listFromJson(data: dataJson)
                                sub.onNext(events)
                                log.info("Load all events: \(events)")
                            }, onError: { (error) in
                                sub.onError(error)
                            })
            
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    static func getStores(in coordinate: CLLocationCoordinate2D) -> Observable<[EVLocation]> {
        
        let url = path + "/locations?current_location_lat=\(coordinate.latitude)&current_location_lng=\(coordinate.longitude)"
        
        return Observable.create({ (sub) -> Disposable in
            
            let request = EVReactNetwork.ev_request(with: .get, header: self.headers, urlString: url, params: nil)
                .subscribe(onNext: { (dataJson) in
                    if dataJson["code"] != 200 {
                        let error = "Code khong phai 200 error: \(dataJson["error"].stringValue)".toError()
                        sub.onError(error)
                        log.error(error)
                        return
                    }
                    
                    let listLocation: [EVLocation] = EVLocation.listFromJson(data: dataJson)
                    sub.onNext(listLocation)
                }, onError: { (error) in
                    sub.onError(error)
                })
            
            return Disposables.create {
                request.dispose()
            }
        })
    }
}
