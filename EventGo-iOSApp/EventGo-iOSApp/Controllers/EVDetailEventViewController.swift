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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        guard event != nil else {
            return
        }
        bindingUI()
        
    }
    
    func bindingUI(){
        nameEventLabel.text = event!.name
        timeStartLabel.text = event!.start_time?.description
        timeEndLabel.text = event!.end_time?.description
        if let url = URL(string: event!.cover_url!){
             coverEventImageView.af_setImage(withURL: url)
        }
        
        print(event?.awards)
       
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
