//
//  EVAppFactoryEvents.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/8/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

import SwiftyJSON
import RxSwift
import RxCocoa

public struct EVAppFactoryEvents {
    
    func loadPresentingEvents() -> Observable<[EVEvent]> {
        
        return Observable.create({ (sub) -> Disposable in
            
            dispatch_main_queue_safe {
                let events: [EVEvent] = evRealm().read()
                sub.onNext(events)
            }

            let request = EVClientService
                .getAllEventsForClient()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (events) in
                    events.save()
                    sub.onNext(events)
                }, onError: { (error) in
                    // xu ly loi thong bao ...
                })
            
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    func loadUserEvents() -> Observable<[EVUserEvent]> {
        
        return Observable.create({ (sub) -> Disposable in
//            dispatch_main_queue_safe {
//                let events: [EVEvent] = evRealm().read()
//                sub.onNext(events)
//            }
            
            let request = EVClientUserService.getAllMyEvents().observeOn(MainScheduler.instance).subscribe(onNext: { (data) in
                if data["code"] == 200 {
                    let listEvent = EVUserEvent.listFromJson(data: data["data"])
                    sub.onNext(listEvent)
                } else {
                    sub.onError("Không parse dc data".toError())
                }
            }, onError: { (error) in
                
            })
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    func loadMyEvents()  -> Observable<[EVEvent]> {
        
        return Observable.create({ (sub) -> Disposable in
            
            dispatch_main_queue_safe {
                let events: [EVEvent] = evRealm().read()
                sub.onNext(events)
            }
            
            let request = EVClientService
                .getAllEventsForClient()
                .subscribe(onNext: { (events) in
                    evRealm().ev_write(events, update: true)
                    sub.onNext(events)
                }, onError: { (error) in
                    // xu ly loi thong bao ...
                })
            
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    func joinEvent(_ event: EVEvent) -> Observable<EVResponseMission> {
        return EVAppFactoryClient.requestMission(EVClientUserService.joinEvent(event.event_id))
    }
    
    func completeEvent(_ event: EVEvent) -> Observable<EVResponseMission> {
        return EVAppFactoryClient.requestMission(EVClientUserService.completeEvent(event.event_id))
    }
    
    func outEvent(_ event: EVEvent) -> Observable<EVResponseMission> {
        return EVAppFactoryClient.requestMission(EVClientUserService.outEvent(event.event_id))
    }
    
    
    
}
