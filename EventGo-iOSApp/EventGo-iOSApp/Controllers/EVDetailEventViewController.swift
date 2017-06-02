//
//  InfoStoreViewController.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/24/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit
import MBProgressHUD
import EZLoadingActivity

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
        
        self.view.isOpaque = false
        self.view.backgroundColor = .clear
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
                        self.awardImageView.image = EVImage.ic_gift.icon()
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
    
    @IBAction func onDetailAwardsAction(_ sender: Any) {
        guard self.listAward.count != 0 else {
            return
        }
        if let vc = EVController.infoAwards.getController() as? EVInfoAwardViewController {
            vc.listAward = listAward
            vc.modalTransitionStyle = .crossDissolve
            vc.definesPresentationContext = true
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: {
                vc.view.backgroundColor = .clear
                vc.view.frame = self.view.frame
            })
        }
        
    }
    
    
    @IBAction func joinEventAction(_ sender: Any) {
       
      
        guard let event = event else {return}
//         MBProgressHUD.showHUDLoading()
        self.showLoading(text: "Đang tải ...")
        _ = EVClientUserService.joinEvent(event.event_id)
            .subscribe(onNext: { (json) in
             
                if json["code"] == 200 {
                    self.hideSuccessLoading(success: true)
                    dispatch_main_queue_safe {
                        let vc = EVController.tasks.getController() as! EVTasksViewController
                        let data = json["data"]
                        vc.idEvent = data["event_id"].stringValue
                        vc.userEvenId = data["_id"].stringValue
                        self.present(vc, animated: true, completion: nil)
                    }
                } else {
                    self.hideSuccessLoading(success: false)
                    dispatch_main_queue_safe {
                        let error = json["error"].stringValue
                        let info = EVPopOverView(frame: CGRect(x: 0,y: 0,width: 300,height: 200), type: .info, icon: EVImage.ic_logo.icon(), title: "Thông báo", content: error)
                        let controller = EVPopOverController(customView: info, height: info.heightView )
                        controller.showView(self, detailBlock: nil) {
                            controller.closeVC()
                        }
                    }
                }
            }, onError: { (error) in
               self.hideLoading()
            })
    }

    
}

// MARK: delegate event scrollView
extension EVDetailEventViewController: UIScrollViewDelegate {

}
