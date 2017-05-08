//
//  EVMarkerManager.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/5/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import GoogleMaps

class EVMarker: GMSMarker {
    
    var id: String!
    init(id: String, location: CLLocationCoordinate2D, title: String, iconName: String) {
        super.init()
        self.position = location
        self.id = id
        self.title = title
        self.icon = UIImage(named: iconName) 
    }
}

class EVMakerManager: NSObject {
    
    static var shareManager: EVMakerManager = EVMakerManager()
    private var markers: [EVMarker] = []
    var mapView: GMSMapView!
        private override init() {
               super.init()
        }

       public func addMarker(_ marker: EVMarker) {
            markers.append(marker)
            marker.map = mapView
       }
    
       public func addMarker(markers: [EVMarker]) {
               // Add mapview
    }
    
    public func deleteMarker(_ id: String) {
        for i in 0...self.markers.count - 1 {
            if(markers[i].id == id) {
                markers[i].map = nil
            }
        }
    }
    
    public func deleteAllMarkers() {
        self.mapView.clear()
    }
}
