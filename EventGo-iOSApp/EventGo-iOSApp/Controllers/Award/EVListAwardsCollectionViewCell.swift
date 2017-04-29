//
//  EVListAwardsCollectionViewCell.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/29/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVListAwardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var awardImageView: UIImageView!
    @IBOutlet weak var nameAwardLabel: UILabel!
    
    func binding(item: EVAwardModel) {
        
        nameAwardLabel.text = item.nameEvent()
        if let url = URL(string: item.avatarEvent()) {
            awardImageView.af_setImage(withURL: url)
        } else {
            awardImageView.image = EVImage.ic_check.icon()
        }
    }
}
