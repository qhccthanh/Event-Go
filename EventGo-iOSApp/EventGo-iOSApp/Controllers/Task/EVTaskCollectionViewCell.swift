//
//  EVTaskCollectionViewCell.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/15/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import GoogleMaps
class EVTaskCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTasksLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var taskDecriptionLabel: UILabel!
    
    func bindingUI(with model: EVTaskModel, location: String) {
        
        nameTasksLabel.text = model.nameEvent()
        addressLabel.text = model.address
        
        if let url = URL(string: model.avatarEvent()) {
            avatarImageView.af_setImage(withURL: url)
        }
        
        taskDecriptionLabel.text = model.descriptionEvent()
        
        switch model.statusTask() {
        case .ready:
            statusLabel.text = "Đang tham gia"
            statusLabel.textColor = UIColor.green
            break
        case .pending :
            statusLabel.text = "Đang chờ"
            statusLabel.textColor = UIColor.red
            break
        default:
            statusLabel.text = "Đã tham gia"
            statusLabel.textColor = UIColor.blue
            break
        }
        
//        EVLocationServices.shareInstance.getDetailLocation(with: location).
        
//        let camera = GMSCameraPosition.camera(withLatitude: location.latitude , longitude: location.longitude, zoom: 13.0)
//        
//        self.mapView.camera = camera
//        self.mapView.isUserInteractionEnabled = false
//        
//        let position = CLLocationCoordinate2D(latitude: location.latitude , longitude: location.longitude)
//        let marker = GMSMarker(position: position)
//        marker.title = model.nameEvent()
//        marker.map = mapView
       
    }
    
}
