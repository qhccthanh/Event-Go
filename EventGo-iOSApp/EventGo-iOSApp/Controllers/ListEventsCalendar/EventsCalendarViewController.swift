//
//  EventsCalendarViewController.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/28/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit

class EventsCalendarViewController: UIViewController {

    @IBOutlet weak var leftConstain: NSLayoutConstraint!
    @IBOutlet weak var upcomingEventsLabel: UILabel!
    @IBOutlet weak var happenEventsLabel: UILabel!
    @IBOutlet weak var happenEventsView: UIView!
    @IBOutlet weak var upcomingEventsView: UIView!
    
    weak var upCommingViewController: ListEventsUpcomingCollectionViewController?
    weak var currentViewController: ListEventsCollectionViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         leftConstain.constant = 0
        upcomingEventsLabel.isHidden = true
        happenEventsLabel.isHidden = false
        
        // Do any additional setup after loading the view.
        for viewcontroller in self.childViewControllers {
            
            if let vc = viewcontroller as? ListEventsUpcomingCollectionViewController {
                self.upCommingViewController = vc
            }
            
            if let vc = viewcontroller as? ListEventsCollectionViewController {
                self.currentViewController = vc
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onhappenEventAction(_ sender: Any) {
        
        leftConstain.constant = 0
        UIView.animate(withDuration: 0.3) { 
            self.view.layoutIfNeeded()
        }
        
        currentViewController?.collectionView?.reloadData()
        
        upcomingEventsLabel.isHidden = true
        happenEventsLabel.isHidden = false
    }

    @IBAction func upcommingeventsAction(_ sender: Any) {
        
        leftConstain.constant = -self.happenEventsView.frame.width
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        upCommingViewController?.collectionView?.reloadData()
        upcomingEventsLabel.isHidden = false
        happenEventsLabel.isHidden = true
    }

}
