//
//  EVEventsViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/2/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVEventsViewController: EVViewController {

    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var happenningButton: UIButton!
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var happeningLabel: UILabel!
    @IBOutlet weak var upcomingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingLabel.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func onHappeningEventsAction(_ sender: Any) {
        leading.constant = 0
        happeningLabel.isHidden = false
        upcomingLabel.isHidden = true
    }
    @IBAction func onUpcomingEventsAction(_ sender: Any) {
        if leading.constant == 0 {
            leading.constant += self.view.frame.width
            happeningLabel.isHidden = true
            upcomingLabel.isHidden = false
        }
    }
}
