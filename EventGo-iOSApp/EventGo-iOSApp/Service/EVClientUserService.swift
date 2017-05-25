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

public class EVClientUserService: BaseService {
    
    override static public var subUrl: String {
        return "client/users"
    }
    
    fileprivate static func getInfo(_ urlString: String, lastTime: TimeInterval = 0) -> Observable<JSON> {
        return EVReactNetwork.ev_request(with: .get, header: self.headers, urlString: urlString, params: ["last_time": lastTime])
    }
    
    static func getAllMyEvents(_ lastTime: TimeInterval = 0) -> Observable<JSON> {
        let urlRequest = path + "/events"
        return getInfo(urlRequest, lastTime: lastTime)
    }
    
    static func joinEvent(_ event_id: String) -> Observable<JSON> {
        let urlRequest = path + "/events/\(event_id)/joinEvent"
        return EVReactNetwork.ev_request(with: .post, header: self.headers, urlString: urlRequest, params: nil)
    }
    
    static func outEvent(_ event_id: String) -> Observable<JSON> {
        let urlRequest = path + "/events\(event_id)/outEvent"
        return EVReactNetwork.ev_request(with: .post, header: self.headers, urlString: urlRequest, params: nil)
    }
    
    static func completeEvent(_ event_id: String) -> Observable<JSON> {
        let urlRequest = path + "/events\(event_id)/completeEvent"
        return EVReactNetwork.ev_request(with: .post, header: self.headers, urlString: urlRequest, params: nil)
    }
    
    static func getAllMyTasks(_ lastTime: TimeInterval = 0) -> Observable<JSON> {
        let urlRequest = path + "/tasks"
        return getInfo(urlRequest, lastTime: lastTime)
    }
    
    static func joinTask(_ task_id: String) -> Observable<JSON> {
        let urlRequest = path + "/tasks\(task_id)/joinTask"
        return EVReactNetwork.ev_request(with: .post, header: self.headers, urlString: urlRequest, params: nil)
    }
    
    static func outTask(_ task_id: String) -> Observable<JSON> {
        let urlRequest = path + "/tasks\(task_id)/outTask"
        return EVReactNetwork.ev_request(with: .post, header: self.headers, urlString: urlRequest, params: nil)
    }
    
    static func completeTask(_ userEventId: String,_ task_id: String, params: [String:Any]) -> Observable<JSON> {
        let urlRequest = path + "/events/\(userEventId)/tasks/\(task_id)/completeTask"
        return EVReactNetwork.ev_request(with: .post, header: self.headers, urlString: urlRequest, params: params)
    }
    
    static func getAllMyAwards(_ lastTime: TimeInterval = 0) -> Observable<JSON> {
        let urlRequest = path + "/awards"
        return getInfo(urlRequest, lastTime: lastTime)
    }
    
    static func getAllMyNotifications(_ lastTime: TimeInterval = 0) -> Observable<JSON> {
        let urlRequest = path + "/notifications"
        return getInfo(urlRequest, lastTime: lastTime)
    }
    
}
