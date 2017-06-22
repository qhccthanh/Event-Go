//
//  EVBaseServices.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 3/30/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//
import Foundation
import SwiftyJSON

open class BaseService {
    
    public let baseURL = EVConstant.isDebug ? "http://localhost:3000/api/v1.0/" : "http://ego.tudienducviet.com/api/v1.0/"
    
    public var subUrl : String {
        get {
            return ""
        }
    }
    public var path : String {
        get {
            return baseURL.appending(subUrl)
        }
    }
    
    public var headers : [String : String] {
        get {
            return [
                "Content-Type": "application/json",
                "withCredentials": "true"
            ]
        }
        
    }
    
    static public let baseURL = EVConstant.isDebug ? "http://localhost:3000/api/v1.0/" : "http://ego.tudienducviet.com/api/v1.0/"
    
    class public var subUrl : String {
        get {
            return ""
        }
    }
    
    static public var path : String {
        get {
            return baseURL.appending(subUrl)
        }
    }
    
    static public var headers : [String : String] {
        get {
            return [
                "Content-Type": "application/json",
                "withCredentials": "true"
            ]
        }
        
    }
    
}
