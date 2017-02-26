//
//  InfoStoreViewController.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/24/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit
import FDRatingView


class InfoStoreViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var ratingView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewratting = FDRatingView(frame: self.ratingView.bounds, style: .star, numberOfElements: 5, fillValue: 2.55, color: .gray, lineWidth: 1.1, spacing: 0.1)
        ratingView.addSubview(viewratting)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func exitAction(_ sender: Any) {
        
        let model = NotificatonModel(title: nil, nameImage: "ic_checked", content: "Bạn đã trúng thưởng ", isShowExitButton: true, isShowHandleButton: false)
        let view = EGoPopupView(frame: CGRect(x: 0, y: 0, width: 216, height: 200))
        view.show(with: model, type: .detail) {
                print("Đã bấm OK")
            }
    }
    
}

// MARK: delegate event scrollView
extension InfoStoreViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        bottomView.isHidden = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        bottomView.isHidden = false
    }
}
