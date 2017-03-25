//
//  ListEventsCollectionViewController.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/28/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ListEventsCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ListEventsCollectionViewCell {
            
        let model = CartoonModel(nameEvent: "Thái", nameImageEvent: "tivi", numberStepEvent: 10)
        cell.bindingUI(with: model)
        return cell
        }
        return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
    }
   
    

}

extension ListEventsCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        if let flow = collectionViewLayout as? UICollectionViewFlowLayout {
            flow.minimumInteritemSpacing = 0.3
            let spacePadding = itemsPerRow * flow.minimumInteritemSpacing
            let widthAvailable = self.view.bounds.width - spacePadding
            let widthItem: CGFloat = widthAvailable/itemsPerRow
            return CGSize(width: widthItem, height: widthItem)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

