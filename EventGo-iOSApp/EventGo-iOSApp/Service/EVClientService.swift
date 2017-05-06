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
    
    override public var subUrl: String {
        return "client"
    }
    
    
    func getAllEventsForClient()-> RACSignal<AnyObject> {
        let url = path + "/events"
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: url, params: nil).subscribeNext({ (object) in
                if let object = object as? NSDictionary {
                  let dataJson = JSON(object)
                    if dataJson["code"] != 200 {
                        sub.sendError("Code khong phai 200".toError())
                    } else {
                        let listEvents: [EVEvent] = EVEvent.listFromJson(data: dataJson)
                        sub.sendNext(listEvents)
                    }
                  
                } else {
                  sub.sendError("Không phải kiểu NSDictionary".toError())
                }
              
              
            }, error: { (error) in
                sub.sendError(error)
            })
            return nil
        })
    }
    
    func getCurrentLocation(location: CLLocationCoordinate2D) -> RACSignal<AnyObject> {
        
        let url = path + "/locations?current_location_lat=\(location.latitude)&current_location_lng=\(location.longitude)"
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: url, params: nil).subscribeNext({ (responseObject) in
                if let responseObject = responseObject as? NSDictionary {
                    let dataJson = JSON(responseObject)
                    if dataJson["code"] == 200 {
                        let listLocation: [EVLocation] = EVLocation.listFromJson(data: dataJson)
                        sub.sendNext(listLocation)
                    } else {
                        sub.sendError("Code khong phai 200".toError())
                    }
                } else {
                    // lỗi k parse dictionary
                    sub.sendError("Không parse được response sang NSDictionaray".toError())
                }
            }, error: { (error) in
                sub.sendError(error)
            })
            
            return nil
        })
    }
    
}
