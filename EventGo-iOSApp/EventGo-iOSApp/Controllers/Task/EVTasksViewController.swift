//
//  EVTasksViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/15/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EVTasksViewController: EVViewController {

    @IBOutlet weak var colletionView: UICollectionView!
    var listTasks: Array<EVTask> = Array<EVTask>()
    var idEvent: String?
    var height: CGFloat = 500.0
    var width: CGFloat = 300.0
    override func viewDidLoad() {
        super.viewDidLoad()
        width = self.view.frame.width - 40
        height = self.view.frame.height - 20
        
        guard self.idEvent != nil else {return}
        _ = EVAppFactory.client.tasks
            .getAllTask(idEvent!)
            .subscribe(onNext: { (tasks) in
                self.listTasks = tasks
                dispatch_main_queue_safe {
                    self.colletionView.reloadData()
                }
            }, onError: { (error) in
                //
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func quitAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension EVTasksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EVTaskCollectionViewCell
        guard self.idEvent != nil || self.listTasks.count > 0 else {return cell}
        let task = listTasks[indexPath.row]
        let model = EVTaskModel(task: task)
        if let infoTask = task.task_info {
            cell.bindingUI(with: model, location: infoTask.location_info!.coordinate)
        } else {
            cell.bindingUI(with: model, location: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20);
    }
}
