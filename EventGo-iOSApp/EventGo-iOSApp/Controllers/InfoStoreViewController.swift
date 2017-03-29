//
//  InfoStoreViewController.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/24/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit

class InfoStoreViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var ratingView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func exitAction(_ sender: AnyObject) {
        
        let model = NotificatonModel(title: nil, nameImage: "ic_checked", content: "Bạn đã trúng thưởng ", isShowExitButton: true, isShowHandleButton: false)
        let view = EVPopupView(frame: CGRect(x: 0, y: 0, width: 216, height: 200))
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
