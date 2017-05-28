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
    
    static func uploadImage(imageStore: EVImageResource, supplierId: String) -> Observable<String> {
        
        let url:String = self.baseURL + "client/users/images?supplier_id=\(supplierId)"
        var params = Dictionary<String, Any>()
        var paramImage = Dictionary<String, String>()
        paramImage["name"] = imageStore.name
        paramImage["detail"] = imageStore.detail
        
        let imageData: Data = UIImageJPEGRepresentation(imageStore.image, 0.8)!
        let base64Encode = imageData.base64EncodedString()
        params["file_encode_64"] = base64Encode
        params["image_description"] = paramImage
        
        return Observable.create({ (sub) -> Disposable in
            
            let request = EVReactNetwork.ev_request(with: EVSReactNetworkMethod.post, header: self.headers, urlString: url, params: params)
                .subscribe(onNext: { (dataJson) in
                if dataJson["code"] != 200 {
                    let error = "Code khong phai 200 error: \(dataJson["error"].stringValue)".toError()
                    sub.onError(error)
                    log.error(error)
                    return
                }
                
                    let json = JSON(dataJson)
//                    let image = EVImageResource(data: json["data"])
                    sub.onNext(dataJson["data"]["image_url"].stringValue)
            }, onError: { (error) in
                sub.onError(error)
            })
            
            return Disposables.create(){
                request.dispose()
            }
        })
    }

    
    static func getAllTasks(_ idEvent: String, userId: String ) -> Observable<[EVTask]>{
        
        let url = path + "events/\(idEvent)/tasks?\(userId)"
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
