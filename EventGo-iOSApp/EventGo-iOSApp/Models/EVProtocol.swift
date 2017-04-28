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
}

class EVEventModel: EVEventProtocol {
    var name: String!
    var imageURL: String!
    var description: String!
    
    init(event: EVEvent) {
        self.name = event.name
        self.imageURL = event.cover_url
        let start_time_string = CTDateFormart(date: event.start_time!).daymonyear()
        let end_time_string = CTDateFormart(date: event.end_time!).daymonyear()
        self.description = "\(start_time_string) - \(end_time_string)"
    }
    
    func nameEvent() -> String! {
        return name
    }
    
    func avatarEvent() -> String! {
        return imageURL
    }
    
    func descriptionEvent() -> String {
        return description
    }
}
