//
//  InfoStoreViewController.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/24/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit

class EVDetailEventViewController: EVViewController {
    
    @IBOutlet weak var coverEventImageView: UIImageView!
    @IBOutlet weak var nameEventLabel: UILabel!
    @IBOutlet weak var timeStartLabel: UILabel!
    @IBOutlet weak var timeEndLabel: UILabel!
    @IBOutlet weak var infoEventLabel: UILabel!
    @IBOutlet weak var awardImageView: UIImageView!
    @IBOutlet weak var nameAwardLabel: UILabel!
    @IBOutlet weak var awardDescriptionLabel: UILabel!
    
    var event: EVEvent?
    var listAward: [EVAward] = [EVAward]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        guard event != nil else {
            return
        }
        bindingUI()
        
    }
    
    func bindingUI(){
        
        let awardObserve = EVEventServices.shareInstance.getListAwards(with: event!.event_id)
        _ = awardObserve.subscribe(onNext: { (listAwardResult) in
            self.listAward = listAwardResult
            
            dispatch_main_queue_safe {
                if let award = self.listAward.max(by: {$0.priority > $1.priority}) {
                     self.nameAwardLabel.text = award.name
                     self.awardDescriptionLabel.text = award.detail
                    if let url = URL(string: award.image_url!) {
                        self.awardImageView.setImageWith(url)
                    } else {
                        self.awardImageView.image = EVImage.ic_check.icon()
                    }
                }
            
            }
        }) { (error) in
            log.error(error)
        }
        nameEventLabel.text = event!.name
        let start_time_string = CTDateFormart(date: event!.start_time!).daymonyear()
        let end_time_string = CTDateFormart(date: event!.end_time!).daymonyear()
        timeStartLabel.text = start_time_string
        timeEndLabel.text = end_time_string
        if let url = URL(string: event!.cover_url!){
             coverEventImageView.af_setImage(withURL: url)
        }
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func joinEventAction(_ sender: Any) {
        
    }

    
}

// MARK: delegate event scrollView
extension EVDetailEventViewController: UIScrollViewDelegate {

}
