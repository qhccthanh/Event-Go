//
//  EVInfoTaskViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/22/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVInfoTaskViewController: EVViewController {
    @IBOutlet weak var awardImageView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.teal()
        awardImageView.dropShadow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
