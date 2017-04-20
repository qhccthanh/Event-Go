//
//  EVListEventsCollectionViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/20/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class EVListEventsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var listEvents:[EVEvent] = [EVEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let eventSignal = EVClientService.shareInstance.getAllEventsForClient()
        eventSignal.subscribeNext({ (listEvents) in
            self.listEvents = listEvents as! [EVEvent]
            dispatch_main_queue_safe {
                self.collectionView?.reloadData()
            }
        }) { (error) in
            log.error(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return listEvents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ListEventsCollectionViewCell
            let event = listEvents[indexPath.row]
            let model = EVEventModel(event: event)
            cell.bindingUI(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}
