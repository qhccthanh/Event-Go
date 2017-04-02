//
//  EVMainGameController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/1/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import GoogleMaps

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
