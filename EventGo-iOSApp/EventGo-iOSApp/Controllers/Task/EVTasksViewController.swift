//
//  EVTasksViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/15/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import GoogleMaps
import EZLoadingActivity

class EVTasksViewController: EVViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var colletionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    var listTasks: Array<EVTask> = Array<EVTask>()
    var idEvent: String?
    var userId: String?
    var userEvenId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.isHidden = true
        
        guard let idFEvent = self.idEvent,
                let userID = EVAppFactory.shareInstance.currentUser?.id
        else {
            return
        }
        
        _ = EVAppFactory.client.tasks
            .getAllTask(idFEvent, userId: userID)
            .subscribe(onNext: { (tasks) in
                self.listTasks = tasks
                self.pageController.numberOfPages = self.listTasks.count
                dispatch_main_queue_safe {
                    if self.listTasks.count > 0 {
                        self.mapView.isHidden = false
                    } else {
                        self.mapView.isHidden = true
                    }
                    self.colletionView.reloadData()
                   }
            }, onError: { (error) in
                
                dispatch_main_queue_safe {
                  
                    let info = EVPopOverView(frame: CGRect(x: 0,y: 0,width: 300,height: 200), type: .info, icon: EVImage.ic_logo.icon(), title: "Thông báo", content: error.localizedDescription)
                    let controller = EVPopOverController(customView: info, height: info.heightView )
                    controller.showView(self, detailBlock: nil) {
                        controller.closeVC()
                    }
                }
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
        guard self.idEvent != nil || self.listTasks.count > 0 || self.userEvenId != nil else {return cell}
        let task = listTasks[indexPath.row]
        let model = EVTaskModel(task: task)
        cell.bindingUI(with: model, infoLocation: task.task_info.location_info) { (sender) in
            
                self.showLoading()
            
                _ = EVAppFactory.client.tasks
                    .joinTask(task, idEvent: self.userEvenId!)
                    .subscribe(onNext: { (result) in
                        
                        if case EVResponseMission.failure(let message) = result {
                            
                            self.hideSuccessLoading(success: true)
                            
                            dispatch_main_queue_safe {
                                let info = EVPopOverView(frame: CGRect(x: 0,y: 0,width: 300,height: 200), type: .info, icon: EVImage.ic_logo.icon(), title: "Thông báo", content: message)
                                let controller = EVPopOverController(customView: info, height: info.heightView )
                                controller.showView(self, detailBlock: nil) {
                                    controller.closeVC()
                                }
                            }
                            
                        } else {
                            dispatch_main_queue_safe {
                                self.hideSuccessLoading(success: false)
                                let vc = EVController.completeTask.getController() as! EVCompleteTaskViewController
                                vc.task = task
                                vc.userEventId = self.userEvenId
                                self.present(vc, animated: true, completion: nil)
                            }
                            
                        }
                    }, onError: { (error) in
                        self.hideLoading()
                    })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.getSize().width, height: collectionView.getSize().height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let model = listTasks[indexPath.row]
        self.pageController.currentPage = indexPath.row
        guard let infoLocation = model.task_info.location_info else {return}
        
        let camera = GMSCameraPosition.camera(withLatitude: infoLocation.coordinate.latitude, longitude: infoLocation.coordinate.longitude, zoom: 13.0)
        
        self.mapView.camera = camera
        self.mapView.isUserInteractionEnabled = false
        
        let position = CLLocationCoordinate2D(latitude: infoLocation.coordinate.latitude, longitude: infoLocation.coordinate.longitude)
        let marker = GMSMarker(position: position)
        marker.title = model.name
        marker.map = self.mapView

    }
}
