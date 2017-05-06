//
//  ReactNetwork+Extension.swift
//  EventGo-iOSApp
//
//  Created by Quach Ha Chan Thanh on 5/6/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

enum EVSReactNetworkMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
    func toNetworkMethod() -> EVReactNetworkMethod {
        switch self {
        case .get:
            return EVReactNetworkMethod_GET
        case .post:
            return EVReactNetworkMethod_POST
        case .put:
            return EVReactNetworkMethod_PUT
        case .delete:
            return EVReactNetworkMethod_DELETE
        }
    }
}

extension EVReactNetwork {
    
    class func ev_request(with method: EVSReactNetworkMethod = .get, header: [AnyHashable: Any]? = nil, urlString: String, params: [AnyHashable: Any]? = nil) -> Observable<JSON> {
        
        log.info("Request URL: \(urlString)")
        log.info("Method: \(method.rawValue)")
        log.info("Header: \(header ?? [:])")
        log.info("Params: \(params ?? [:])")
        
        return Observable.create {
            subs in
            
            let request = EVReactNetwork.request(with: method.toNetworkMethod(), header: header ?? [:], urlString: urlString, params: params ?? [:]).subscribeNext({
                (result) in
                
                log.info("Result: \(result) from: \(urlString)")
                guard let result = result else {
                    let error = "Result API nil".toError()
                    log.error(error)
                    subs.onError(error)
                    return
                }
                
                let dataJson = JSON(result)
                subs.onNext(dataJson)
            }, error: { (error) in
                log.error("Error: \(error ?? "Error not found".toError()) from: \(urlString)")
                subs.onError(error ?? NSError.defaultAPIError())
            })
            
            return Disposables.create {
                log.info("Stop task \(urlString)")
                request.dispose()
            }
        }
    }
}
