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
     
        
        if (nameEventLabel) != nil {
            nameEventLabel.text = eventModel.nameEvent()
        }
   
        if (timeLabel) != nil {
            timeLabel.text = "Từ \(eventModel.startDay()!) đến \(eventModel.endDay()!)"
        }
        if let url = URL(string: eventModel.avatarEvent()){
            avatarEventImageView.af_setImage(withURL: url)
        }
        
        if numberTaskLabel != nil {
            let caseEvent = eventModel.statusEvent()
            switch caseEvent! {
            case .preparing:
                numberTaskLabel.text = "Sắp diễn ra"
                break
            case .stagging:
                numberTaskLabel.text = "Đang diễn ra"
                break
            default:
                numberTaskLabel.text = "Đã kết thúc"
            }
        }
        
    }
    
}
