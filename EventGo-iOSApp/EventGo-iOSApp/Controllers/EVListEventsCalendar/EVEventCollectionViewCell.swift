//
//  EVEventCollectionViewCell.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/2/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVEventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameSupplierLabel: UILabel!
    @IBOutlet weak var avatarEventsImageView: UIImageView!
    @IBOutlet weak var nameEventLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    func bindingUI(mode: EVEventModel ){
        self.nameEventLabel.text = mode.nameEvent()
        self.nameSupplierLabel.text = mode.nameSupplier()
        if let url = URL(string: mode.avatarEvent()){
            avatarEventsImageView.af_setImage(withURL: url)
        }
        startTimeLabel.text = mode.startDay()
        endTimeLabel.text = mode.endDay()
     }
}
