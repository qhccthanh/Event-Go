//
//  EVListHappeningEventsCollectionViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/2/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class EVListHappeningEventsCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EVEventCollectionViewCell
    
        return cell
    }
}

extension EVListHappeningEventsCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 250)
    }
}
