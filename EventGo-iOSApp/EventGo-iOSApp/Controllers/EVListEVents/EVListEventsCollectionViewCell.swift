//
//  EVListEventsCollectionViewCell.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/22/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import AlamofireImage
class EVListEventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avatarEventImageView: UIImageView!
    @IBOutlet weak var nameEventLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberTaskLabel: UILabel!
    @IBOutlet weak var contentCell: UIView!
    
    func bindingUI(with eventModel: EVEventModel){
     
        
        if let nameEvent = nameEventLabel {
            nameEventLabel.text = eventModel.nameEvent()
        }
        
        if let time = timeLabel {
            timeLabel.text = eventModel.descriptionEvent()
        }
        if let url = URL(string: eventModel.imageURL){
            avatarEventImageView.af_setImage(withURL: url)
        }
        
    }
    
}
