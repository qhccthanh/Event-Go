//
//  EVProtocol.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/20/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

protocol EVEventProtocol {
    
    func nameEvent() -> String!
    func avatarEvent() -> String!
    func descriptionEvent() -> String
    
    func startDay() -> String!
    func endDay() -> String!
}

extension EVEventProtocol {
    
    func startDay() -> String! {
        return ""
    }
    
    func endDay() -> String! {
        return ""
    }
    
    func descriptionEvent() -> String {
        return ""
    }
}

class EVTaskModel: EVEventProtocol {
   
    var name: String!
    var image_url: String?
    var address: String!
    var status: String!
    var description: String!
    
    init(task: EVTask) {
        
        self.name = task.name
        self.image_url = task.thumbnail_url
        self.address = task.task_info.address
        self.status = task.status
        self.description = task.descriptionTask
    }
    
    func nameEvent() -> String! {
        return self.name
    }

    func avatarEvent() -> String! {
        return self.image_url ?? ""
    }

    func statusTask() -> EVTaskStatus {
        return raw(self.status)
    }
    
    func descriptionEvent() -> String {
        return self.description
    }
    
    func addressTask() -> String {
        return self.address
    }
    
    func raw(_ status: String) -> EVTaskStatus!{
        
        switch status {
            
        case "opening":
            return .pending
        case "ready":
            return .ready
        default:
            return .finished
            
        }
    }
    
}

class EVAwardModel: EVEventProtocol {
    
    var nameAward: String!
    var avatarAward: String!
    
    init(award: EVAward) {
        
        self.nameAward = award.name
        self.avatarAward = award.image_url
    }
    
    func avatarEvent() -> String! {
        return avatarAward
    }
    
    func nameEvent() -> String! {
        return nameAward
    }
}

class EVEventModel: EVEventProtocol {
    
    private var name: String!
    private var imageURL: String!
//    var description: String!
    private var start_day: String!
    private var end_day: String!
    private var supplier: String
    private var status: String
    
    init(event: EVEvent) {
//        self.name = event.name
//        self.imageURL = event.cover_url
//        let start_time_string = CTDateFormart(date: event.start_time!).daymonyear()
//        let end_time_string = CTDateFormart(date: event.end_time!).daymonyear()
//        self.description = "\(start_time_string) - \(end_time_string)"
        
        self.name = event.name
        self.imageURL = event.cover_url
        self.start_day = CTDateFormart(date: event.start_time!).daymonyear()
        self.end_day = CTDateFormart(date: event.end_time!).daymonyear()
        self.supplier = event.supplier_id
        self.status = event.status
    }
    
    
    func nameEvent() -> String! {
        return name
    }
    
    func nameSupplier() -> String! {
        return supplier
    }
    
    func startDay() -> String! {
        return self.start_day
    }
    
    func endDay() -> String! {
        return self.end_day
    }
    
    func avatarEvent() -> String! {
        return imageURL
    }
    
    func statusEvent() -> EVEventStatus! {
        return raw(self.status)
    }
    
    func raw(_ status: String) -> EVEventStatus!{
        
        switch status {
            
        case "preparing":
            return .preparing
        case "stagging":
            return .stagging
        default:
            return .expired
            
        }
    }
    
//    func descriptionEvent() -> String {
//        return "\(self.start_day)-\(self.end_day)"
//    }
}
