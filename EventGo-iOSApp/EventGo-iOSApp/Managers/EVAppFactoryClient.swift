
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

public struct EVAppFactoryClient {
    
    func loadEvents() -> Observable<[EVEvent]> {
        
        return Observable.create({ (sub) -> Disposable in
            
            let events: [EVEvent] = evRealm().read()
            sub.onNext(events)
            
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
    
    func loadLocations(coordinate: CLLocationCoordinate2D) -> Observable<[EVLocation]> {
        
        return Observable.create({ (sub) -> Disposable in
            
            let locations: [EVLocation] = evRealm().read()
            sub.onNext(locations)
            
            let request = EVClientService
                .getStores(in: coordinate)
                .subscribe(onNext: { (locations) in
                    evRealm().ev_write(locations, update: true)
                    sub.onNext(locations)
                }, onError: { (error) in
                    // xu ly loi thong bao ...
                })
            
            return Disposables.create {
                request.dispose()
            }
        })
    }
}
