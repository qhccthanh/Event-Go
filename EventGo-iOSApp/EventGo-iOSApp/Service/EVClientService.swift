//
//  EVClientService.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/11/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import SwiftyJSON
public class EVClientService: BaseService {
    
    static let shareInstance = EVClientService()
    
    override var subUrl: String{
        return "client"
    }
    
    
    func getAllEventsForClient()-> RACSignal<AnyObject> {
        let url = path + "/events"
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: url, params: nil).subscribeNext({ (object) in
                if let object = object as? NSDictionary {
                  let dataJson = JSON(object)
                    if dataJson["code"] != 200 {
                        sub.sendError("Code khong phai 200" as? Error)
                    } else {
                        let listEvents: [EVEvent] = EVEvent.listFromJson(data: dataJson)
                        sub.sendNext(listEvents)
                    }
                  
                } else {
                  sub.sendError("Không phải kiểu NSDictionary" as? Error)
                }
              
              
            }, error: { (error) in
                sub.sendError(error)
            })
            return nil
        })
    }
    
}
