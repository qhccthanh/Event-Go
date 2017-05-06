//
//  EVUserServices+Event.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/5/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SwiftyJSON

extension EVUserServices {
    
    func getAllEvent() -> Observable<JSON> {
        
        return Observable.create() {
            sub in
            _ = EVReactNetwork.ev_request(with: .get, header: self.headers, urlString: "", params: nil)
            return Disposables.create {
                
            }
        }
    }
    
    func getAllTask(_ event_id: String) -> Observable<JSON> {
        
        return Observable.create() {
            obser in
            
            return Disposables.create()
        }
    }
    
}
