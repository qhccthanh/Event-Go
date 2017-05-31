//
//  EVListHappeningEventsCollectionViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/2/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

private let reuseIdentifier = "Cell"

class EVListHappeningEventsCollectionViewController: UICollectionViewController {
    
    var listEvents:[EVEvent] = [EVEvent]()
    var widthItem: CGFloat = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        getListEventHappening()
//        let lstSup:[EVSupplier]  = evRealm().read()
        let itemsPerRow: CGFloat = 2
        let spacePadding = itemsPerRow * 2
        let widthAvailable = self.view.bounds.width - spacePadding - 30
        widthItem = widthAvailable/itemsPerRow
        
        self.collectionView?.emptyDataSetDelegate = self
        self.collectionView?.emptyDataSetSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func getListEventHappening(){
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

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listEvents.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EVEventCollectionViewCell
        let event = listEvents[indexPath.row]
        let model = EVEventModel(event: event)
        cell.bindingUI(mode: model)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = listEvents[indexPath.row]
//        self.dismiss(animated: true, completion: nil)
        let vc = EVController.detailEvent.getController() as! EVDetailEventViewController
        vc.event = event
        vc.modalTransitionStyle = .crossDissolve
        vc.definesPresentationContext = true
        vc.modalPresentationStyle = .overCurrentContext
        if let parentController = self.parent {
            parentController.present(vc, animated: true, completion: nil)
//            vc.view.frame.origin.y = parentController.view.frame.origin.y
        }
//        self.dismiss(animated: true, completion: nil)
    }

}

extension EVListHappeningEventsCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionViewLayout is UICollectionViewFlowLayout {
            return CGSize(width: widthItem, height: 250)
        }
        
        return CGSize(width: widthItem, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

extension EVListHappeningEventsCollectionViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text: String = "No events in here"
        let attributes: [AnyHashable: Any] = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(18.0)), NSForegroundColorAttributeName: UIColor.darkGray.withAlphaComponent(0.6)]
        return NSAttributedString(string: text, attributes: attributes as? [String : Any])
    }
}
