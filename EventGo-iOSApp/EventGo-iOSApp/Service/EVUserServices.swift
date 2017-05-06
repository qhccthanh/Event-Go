//
//  EVUserServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/31/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//
import Foundation
import UIKit

import RxSwift
import RxCocoa
import SwiftyJSON

public class EVUserServices: BaseService {
    
    static let shareInstance = EVUserServices()
    
    override var subUrl: String{
        return "users"
    }
    
    func signOut() -> Observable<JSON> {
        let url = path + "/signOut"
        return EVReactNetwork.ev_request(with: .post, header: self.headers, urlString: url, params: nil)
    }
        
    func updateUserInfo(with params: [String: Any]) -> Observable<EVUpdateResult> {
        return Observable.create({ (sub) -> Disposable in
            
            let request = EVReactNetwork.ev_request(with: .put, header: self.headers, urlString: self.path, params: params)
                .subscribe(onNext: { (json) in
                    
                    let result = json["code"] == 200 ? EVUpdateResult.success : EVUpdateResult.faillure
                    sub.onNext(result)
                }, onError: { (error) in
                    sub.onNext(.faillure)
                })
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    func authorizedUser() -> Observable<EVCheckUserEnumType> {
        let url = path + "/me"
        return Observable.create({ (sub) -> Disposable in
            let request = EVReactNetwork
                .ev_request(with: .get, header: self.headers, urlString: url, params: nil)
                .subscribe(onNext: { (json) in
                    // Check user state
                    self.checkUserData(sub,data: json)
                }, onError: { (error) in
                    sub.onError(error)
                })
            
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    func checkUserData(_ sub: AnyObserver<EVCheckUserEnumType>,data dataJson: JSON) {
        if dataJson["code"] != 200 {
            sub.onNext(EVCheckUserEnumType.notLogin)
            return
        }
        
        let userCurrent = EVUser.fromJson(data: dataJson["data"])
        EVAppFactory.shareInstance.currentUser = userCurrent
        let result = userCurrent.image_url == "" || userCurrent.name == "" ?
            EVCheckUserEnumType.updatedInfo :
            EVCheckUserEnumType.login
        sub.onNext(result)
    }
    
    func updateDeviceInfo(with params: [String: Any]) -> Observable<EVUpdateResult> {
        
        return Observable.create({ (sub) -> Disposable in
            let request = EVReactNetwork.ev_request(with: .put, header: self.headers, urlString: self.path, params: params)
                .subscribe(onNext: { (json) in
                    
                    let result = json["code"] == 200 ? EVUpdateResult.success : EVUpdateResult.faillure
                    sub.onNext(result)
                }, onError: { (error) in
                    sub.onError(error)
                })
            return Disposables.create {
                request.dispose()
            }
        })
    }
    
    
    func signIn(with params: Dictionary<String, Any>) -> Observable<JSON> {
        return EVReactNetwork.ev_request(with: .post, header: self.headers, urlString: self.path, params: params)
    }

}
