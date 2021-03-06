//
//  EVListEventsCollectionViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/22/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

private let reuseIdentifier = "cell"

class EVListEventsViewController: EVViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var listEvents:[EVUserEvent] = [EVUserEvent]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.modalTransitionStyle = .coverVertical
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.isOpaque = false
        self.view.backgroundColor = .clear
        
        // set delegate when no have data
        self.collectionView.emptyDataSetSource = self
        self.collectionView.emptyDataSetSource = self
        
        _ = EVAppFactory.client.events
            .loadUserEvents()
            .subscribe(onNext: { (events) in
                self.listEvents = events
                dispatch_main_queue_safe {
                    self.collectionView.reloadData()
                }
            }, onError: { (error) in
                
            })
        
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
        let condition = "event_id == \"\(event.event_id!)\""
        let eventInfo: EVEvent? = evRealm().filter(condition).first      
        guard eventInfo != nil else {
            return cell
        }
        let model = EVEventModel(event: eventInfo!)
        cell.bindingUI(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = listEvents[indexPath.row]
        let vc = EVController.tasks.getController() as! EVTasksViewController
        vc.idEvent = event.event_id
        vc.userEvenId = event.id
        vc.userId = event.user_id
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

extension EVListEventsViewController : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text: String = "Bạn chưa tham gia sự kiện nào"
        let attributes: [AnyHashable: Any] = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(18.0)), NSForegroundColorAttributeName: UIColor.darkGray.withAlphaComponent(0.6)]
        return NSAttributedString(string: text, attributes: attributes as? [String : Any])
    }
}
