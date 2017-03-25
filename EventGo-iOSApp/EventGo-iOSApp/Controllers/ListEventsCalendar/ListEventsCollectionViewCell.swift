//
//  ListEventsCollectionViewCell.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/28/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit

class ListEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberAwardLabel: UILabel!
    @IBOutlet weak var awardIamageView: UIImageView!
    @IBOutlet weak var nameEventLabel: UILabel!
    
    weak var itemProtocol: ItemEventProtocol?
    
    func bindingUI(with model: ItemEventProtocol) {
        
        self.itemProtocol = model
        
        if let numberAwardLabel = numberAwardLabel{
            numberAwardLabel.text = model.subTitleItem()
        }
        
        if let awardIamageView = awardIamageView {
            awardIamageView.image = model.imageItem()
        }
        
        if let nameEventLabel = nameEventLabel {
            nameEventLabel.text = model.titleItem()
        }
    }
    
    override func prepareForReuse() {
        if let numberAwardLabel = numberAwardLabel{
            numberAwardLabel.text = nil
        }
        
        if let awardIamageView = awardIamageView {
            awardIamageView.image = nil
        }
        
        if let nameEventLabel = nameEventLabel {
            nameEventLabel.text = nil
        }
    }
}
