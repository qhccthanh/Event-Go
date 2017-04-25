//
//  EVUserServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/31/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//
import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa
import SwiftyJSON
import enum Result.NoError

public class EVUserServices: BaseService {
    
    static let shareInstance = EVUserServices()
    
    override var subUrl: String{
        return "users"
    }
    
    func logOut()->RACSignal<AnyObject> {
        
        let url = path + "/signOut"
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            EVReactNetwork.request(with: EVReactNetworkMethod_POST, header: self.headers, urlString: url, params: nil).subscribeNext({ (result) in
                log.info(result)
                
            }, error: { (error) in
                log.error(error)
            })
            return nil
        })
        
    }
    
    //    func checkInfoUser() -> RACSignal<NSDictionary>{
    //
    //        let url = path + "/me"
    //
    //        return RACSignal.createSignal({ (sub) -> RACDisposable? in
    //            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: url, params: nil).subscribeNext({ (result) in
    //                if let result = result as? NSDictionary {
    //                    sub.sendNext(result)
    //                } else {
    //                    sub.sendError("Lỗi không parse được data" as? Error)
    //                }
    //
    //            }, error: { (error) in
    //                log.error(error)
    //            })
    //            return nil
    //        })
    //    }
    func updateUserInfologin(with params: Dictionary<String, Any>)-> RACSignal<AnyObject> {
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            EVReactNetwork.request(with: EVReactNetworkMethod_PUT, header: self.headers, urlString: self.path, params: params).subscribeNext({ (object) in
                let dataJson =  JSON(object)
                if dataJson["code"] == 200 {
                    sub.sendNext(EVUpdateResult.success)
                } else {
                    sub.sendNext(EVUpdateResult.faillure)
                }
            }, error: { (error) in
                sub.sendError(error)
            })
        })
    }
    
    func checkInfoUser() -> RACSignal<AnyObject>{
        
        let url = path + "/me"
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_GET, header: self.headers, urlString: url, params: nil).subscribeNext({ (result) in
                if let result = result as? NSDictionary {
                    let dataJson = JSON(result)
                    if dataJson["code"] == 200{
                        
                        let userCurrent = EVUser.fromJson(data: dataJson["data"])
                        log.info(dataJson)
                        EVAppFactory.shareInstance.currentUser = userCurrent
                        
                        if (userCurrent.image_url != "" || userCurrent.name == "") {
                            
                            sub.sendNext(EVCheckUserEnumType.updatedInfo)
                        } else {
                            
                            sub.sendNext(EVCheckUserEnumType.login)
                        }
                        
                    } else {
                        sub.sendNext(EVCheckUserEnumType.notLogin)
                    }
                    
                } else {
                    
                    sub.sendError("Lỗi không parse được data" as? Error)
                }
                
            }, error: { (error) in
                log.error(error)
            })
            return nil
        })
    }
    
    
    func login(with token: String, type: String, idUser: String?)-> RACSignal<AnyObject> {
        
        var params = Dictionary<String, Any>()
        params["provider_type"] = type
        params["provider_access_token"] = token
        if let idUser = idUser {
            params["provider_id"] = idUser
        }
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_POST, header: self.headers, urlString: self.path, params: params).subscribeNext({ (object) in
                // Co the la NSDictionary kiem tra ky
                let dataJSon = JSON(object!)
                if dataJSon["code"] == 200 {
                    let user = EVUser.fromJson(data: dataJSon["data"])
                    sub.sendNext(user)
                }
            }, error: { (error) in
                
                sub.sendError(error)
            })
            return nil
        })
    }
    
    func updateUserDevice() -> RACSignal<AnyObject> {
        var params = Dictionary<String, Any>()
        let device = EVDevice(model: UIDevice.current.name, iosVersion: UIDevice.current.systemVersion)
        
        params["device"] = device.toJson()
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_PUT, header: self.headers, urlString: self.path, params: params).subscribeNext({ (object) in
                
                if let object = object as? NSDictionary {
                    
                    let dataJson = JSON(object)
                    
                    if dataJson["code"] == 200 {
                        sub.sendNext(EVUpdateResult.success)
                    } else {
                        sub.sendNext(EVUpdateResult.faillure)
                    }
                    
                } else {
                    
                    sub.sendError("Lỗi không parse được data ".toError())
                }
            }, error: { (error) in
                
                sub.sendError(error)
            })
            
            return nil
        })
        
    }
    
    
    func login(with params: Dictionary<String, Any>)-> RACSignal<NSDictionary> {
        
        return RACSignal.createSignal({ (sub) -> RACDisposable? in
            
            EVReactNetwork.request(with: EVReactNetworkMethod_POST, header: self.headers, urlString: self.path, params: params).subscribeNext({ (object) in
                if let object = object as? NSDictionary {
                    
                    sub.sendNext(object)
                } else {
                    
                    sub.sendError("Lỗi không parse được data" as? Error)
                }
            }, error: { (error) in
                
                sub.sendError(error)
            })
            
            return nil
        })
    }
    
    
    
}
