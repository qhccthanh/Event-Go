//
//  EVListAwardsViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/23/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
private let reuseIdentifier = "cell"
class EVListAwardsViewController: EVViewController {
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    fileprivate let itemsPerRow:CGFloat = 2
    var itemSize: CGSize!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let spacePadding = itemsPerRow*0.3
        let widthAvailable = self.view.bounds.width - spacePadding
        let widthItem: CGFloat = widthAvailable/itemsPerRow
        itemSize = CGSize(width: widthItem, height: widthItem)
    }
    
}

extension EVListAwardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EVStoreCollectionViewCell {
            let itemEventCartoon = CartoonModel(nameEvent: "Circle K", nameImageEvent: "iconGoc", numberStepEvent: 3)
//            cell.bindingUI(itemAward: itemEventCartoon)
            return cell
        }
        return UICollectionViewCell(frame: CGRect(x: 0,y: 0,width: 10,height: 10))
        // Configure the cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        //1
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerViewStore",
                                                                             for: indexPath) as! StoreHeaderView
            
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
    
    // MERK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let flow = collectionViewLayout as? UICollectionViewFlowLayout {
            flow.minimumInteritemSpacing = 0.3
            return itemSize
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
    }
    
}
