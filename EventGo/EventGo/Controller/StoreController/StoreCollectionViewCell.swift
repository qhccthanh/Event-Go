//
//  StoreCollectionViewCell.swift
//  FOODO
//
//  Created by Nguyen Xuan Thai on 12/16/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class StoreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var nameEvent: UILabel!
    @IBOutlet weak var numberStepEvent: UILabel!
    
    func bindingUI(itemEvent: ItemEventProtocol){
        if let imageEvent = imageEvent {
            imageEvent.image = itemEvent.imageItem()
        }
        
        if let nameEvent = nameEvent {
            nameEvent.text = itemEvent.titleItem()
        }
        
        if let numberStepEvent = numberStepEvent {
            numberStepEvent.text = itemEvent.subTitleItem()
        }
    }
    
    override func prepareForReuse() {
        if let imageEvent = imageEvent {
            imageEvent.image = nil
        }
        
        if let nameEvent = nameEvent {
            nameEvent.text = nil
        }
        
        if let numberStepEvent = numberStepEvent {
            numberStepEvent.text = nil
        }
    }
    
}
