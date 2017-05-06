//
//  EVEventServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import RxSwift
import RxCocoa

public class EVEventServices: BaseService {
    
    static let shareInstance = EVEventServices()
    
    override public var subUrl: String{
        return "events"
    }
 
    
    func getDetailEvent(with id: String)-> RACSignal<AnyObject> {
        let url = path + "\(id)"
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: url, params: nil).subscribeNext({ (object) in
                    sub.sendNext(object)
            }, error: { (error) in
                sub.sendError(error)
            })
            return nil
        })
    }
    

    func getListAwards(with id: String) -> Observable<[EVAward]> {
        let url = baseURL + "client/events/\(id)/awards"
        
        return Observable.create({ (sub) -> Disposable in
            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: url, params: nil).subscribeNext({ (respone) in
                if let dataDic = respone as? NSDictionary {
                    let dataJson = JSON(dataDic)
                    if dataJson["code"] == 200 {
                        let listAward = EVAward.fromArrayJson(data: dataJson)
                        sub.onNext(listAward)
                    } else {
                    
                        sub.onError(dataJson["error"].stringValue.toError())
                    }
                
                } else {
                    sub.onError("Không parse được Data".toError())
                }
                
            }, error: { (error) in
                sub.onError(error ?? "Không xác định lỗi".toError())
            })
           return Disposables.create()
        })  as Observable<[EVAward]>
    }
    
}
