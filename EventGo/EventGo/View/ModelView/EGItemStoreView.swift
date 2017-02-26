//
//  EGItemStore.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/25/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit

class EGItemStoreView: UIView {
    
    @IBOutlet weak var ItemImageView: UIImageView!
    @IBOutlet weak var numberItem: UILabel!
    @IBOutlet weak var nameItem: UILabel!
    
    weak var itemModel: ItemEventProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    convenience init(frame: CGRect, itemModel: ItemEventProtocol){
        self.init(frame: frame)
        self.itemModel = itemModel
        setup()
    }
    
    func setup(){
//        ItemImageView.image = itemModel?.imageItem()
//        numberItem.text = itemModel?.subTitleItem()
//        nameItem.text = itemModel?.titleItem()
        let view = Bundle.main.loadNibNamed("EGItemStoreView", owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    
}
