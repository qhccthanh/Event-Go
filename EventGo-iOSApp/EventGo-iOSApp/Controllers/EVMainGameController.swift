//
//  EVMainGameController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/1/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import GoogleMaps

class EVMarker: NSObject {
    
    var id: String!
    
}

class EVMakerManager: NSObject {
    
    static var shareManager: EVMakerManager = EVMakerManager()
    
    var markers: [EVMarker] = []
    var mapView: GMSMapView!
    
    private override init() {
         super.init()
        
    }
    
    public func addMarker(_ marker: EVMarker) {
        // Add mapview
    }
    
    public func addMarker(markers: [EVMarker]) {
        // Add mapview
    }
    
    public func deleteMarker(_ marker: EVMarker) {
        
    }
    
    public func deleteMarker(id: String) {
        
    }
    
    // de
    
}

class EVMainGameController: UIViewController {

    @IBOutlet var mainMapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 10.756927 , longitude: 106.684670, zoom: 13.0)
        self.mainMapView.camera = camera
         
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
