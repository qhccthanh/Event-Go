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
    @IBOutlet weak var buttonJoinTask: EGoButton!
    var blockJoinTask: ((Any)->Void)!
    func bindingUI(with model: EVTaskModel, infoLocation: EVInfoLocation?, block: @escaping (Any)-> Void) {
        
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
            self.buttonJoinTask.isHidden = true
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
        
        self.blockJoinTask = block
       
    }
    
    @IBAction func onJoinTaskAction(_ sender: Any) {
        blockJoinTask?(sender)
    }
}
