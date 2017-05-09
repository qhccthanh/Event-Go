//
//  EVListEventsCollectionViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/22/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class EVListEventsViewController: EVViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var listEvents:[EVEvent] = [EVEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = EVAppFactory.client.events
            .loadPresentingEvents()
            .subscribe(onNext: { (events) in
                self.listEvents = events
                dispatch_main_queue_safe {
                    self.collectionView?.reloadData()
                }
            }, onError: { (error) in
                // xu ly loi thong bao ...
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.listEvents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EVListEventsCollectionViewCell
        let event = listEvents[indexPath.row]
        let model = EVEventModel(event: event)
        cell.bindingUI(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = listEvents[indexPath.row]
        
        let vc = EVController.detailEvent.getController() as! EVDetailEventViewController
        vc.event = event
        self.present(vc, animated: true, completion: nil)
    }

}

extension EVListEventsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}
