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
    var idEvent: String? = "58e9304064e8f1356d8e4ec8"
    var height: CGFloat = 500.0
    var width: CGFloat = 300.0
    override func viewDidLoad() {
        super.viewDidLoad()
        width = self.colletionView.frame.width - 40
        height = self.colletionView.frame.height - 20
        
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
        let task = listTasks[indexPath.row]
        let model = EVTaskModel(task: task)
        cell.bindingUI(with: model, location: task.task_info.location_info!.coordinate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20);
    }
}
