//
//  EVTaskServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import RxSwift

class EVTaskServices: BaseService {

    override var subUrl: String {
        return "events"
    }
    
   static func getAllTasks(_ idEvent: String ) -> Observable<[EVTask]>{
        
        let url = path + "events/\(idEvent)/tasks"
        return Observable.create({ (sub) -> Disposable in
            
            let request = EVReactNetwork.ev_request(with: .get, header: self.headers, urlString: url, params: nil)
                .subscribe(onNext: { (dataJson) in
                    if dataJson["code"] != 200 {
                        let error = "Code khong phai 200 error: \(dataJson["error"].stringValue)".toError()
                        sub.onError(error)
                        log.error(error)
                        return
                    }
                    
                    let task: [EVTask] = EVTask.listFromJson(data: dataJson["data"])
                    sub.onNext(task)
                }, onError: { (error) in
                    sub.onError(error)
                })
            
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    func getDetailTaskOfEvent(with idTask: String)-> RACSignal<AnyObject> {
        let url = path + "\(idTask)"
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: url, params: nil).subscribeNext({ (object) in
                sub.sendNext(object)
            }, error: { (error) in
                sub.sendError(error)
            })
            return nil
        })
    }

}
