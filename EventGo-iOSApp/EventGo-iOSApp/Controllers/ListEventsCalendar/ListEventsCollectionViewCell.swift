//
//  ListEventsCollectionViewCell.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/28/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit
import AlamofireImage

class ListEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberAwardLabel: UILabel!
    @IBOutlet weak var awardIamageView: UIImageView!
    @IBOutlet weak var nameEventLabel: UILabel!
    
    
    func bindingUI(with eventModel: EVEventModel){
        
        if let nameEvent = nameEventLabel {
            nameEventLabel.text = eventModel.nameEvent()
        }
        
        if let numberAwardLabel = numberAwardLabel {
            numberAwardLabel.text = eventModel.descriptionEvent()
        }
        if let url = URL(string: eventModel.imageURL){
             awardIamageView.af_setImage(withURL: url)
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
