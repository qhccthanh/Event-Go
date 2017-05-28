//
//  EVListUserEventsViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/27/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVListUserEventsViewController: EVViewController {
    
//    MARK: declare outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
//    
    fileprivate var widthItem: CGFloat = 0
    var listUserTask: [EVUserTask] = [EVUserTask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.getMyTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getMyTasks()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.modalTransitionStyle = .coverVertical
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
    }
    
    fileprivate func getMyTasks(){
        _ = EVAppFactory.client.tasks
            .getMyTasks()
            .subscribe(onNext: { (listTasks) in
                
                self.listUserTask = listTasks
                dispatch_main_queue_safe {
                    self.collectionView.reloadData()
                }
                
            }, onError: { (error) in
                log.error(error)
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//    MARK: Action quit view
    @IBAction func onQuitAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//  MARK: collectionView Delegate and Datasource
extension EVListUserEventsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listUserTask.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EVUserEventCell
        let userTask = listUserTask[indexPath.row]
        let model = EVTaskModel(userTask: userTask)
        cell.bindingUI(model: model) { (sender) in
            dispatch_main_queue_safe {
                let vc = EVController.completeTask.getController() as! EVCompleteTaskViewController
                vc.task = userTask.task
                vc.userEventId = userTask.user_event_id
                self.present(vc, animated: true, completion: nil)
            }
        }
        return cell
    }
}

// MARK: Config size item in collectionView
extension EVListUserEventsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
            let itemsPerRow: CGFloat = 2
            if let flow = collectionViewLayout as? UICollectionViewFlowLayout {
                flow.minimumInteritemSpacing = 0.3
                let spacePadding = itemsPerRow * flow.minimumInteritemSpacing
                let widthAvailable = self.collectionView.bounds.width - spacePadding
                self.widthItem = widthAvailable / itemsPerRow
                if (self.widthItem >= 100) {
                    return CGSize(width: widthItem, height: 220)
                }
            }
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
    }
    
  
}

// MARK: cell of collection view
class EVUserEventCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewEvent: UIImageView!
    @IBOutlet weak var labelTaskName: UILabel!
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var buttonCompleteTask: EGoButton!
    
    var blockJoinTask: ((Any)->Void)!
    
    override func layoutSubviews() {
        self.viewBackground.showShadow(1, color: UIColor.gray, opacity: 0.5)
    }
    
    func bindingUI(model: EVTaskModel,  block: @escaping (Any)-> Void) {
        
        if let url = URL(string: model.avatarEvent()){
             imageViewEvent.af_setImage(withURL: url)
        }
       
        labelTaskName.text = model.nameTask()
        labelEventName.text = model.nameEvent()
        self.blockJoinTask = block
        switch model.statusUserTask() {
        case .doing:
            labelStatus.text = "Chưa thực hiện"
            labelStatus.textColor = UIColor.black
            buttonCompleteTask.isHidden = false
            break
        case .cancel:
            labelStatus.text = "Đã hủy"
            labelStatus.textColor = UIColor.red
            buttonCompleteTask.isHidden = true
            break
            
        default:
            labelStatus.text = "Đã hoàn thành"
            labelStatus.textColor = UIColor.blue.withAlphaComponent(0.7)
            buttonCompleteTask.isHidden = true
            break
        }
        
       
    }
    
    @IBAction func onSeeTasksAction(_ sender: Any) {
        if blockJoinTask != nil {
            blockJoinTask!(sender)
        }
    }
}
