//
//  EVCompleteTaskViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/16/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import SystemConfiguration
import MBProgressHUD
import RxSwift
import FBSDKShareKit
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON
import EZLoadingActivity

class EVCompleteTaskViewController: EVViewController {

    @IBOutlet weak var chooseImageView: DashView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var labelAddress: UILabel!
    
    var task: EVTask?
    var userEventId: String?
    var idPost: String?
    
    var imageSeleted: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    var locationManager = CLLocationManager()
    var myLocation: CLLocationCoordinate2D?
    @IBAction func takePhotoAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.camera
            imgPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
            
            self.present(imgPicker, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }
    
    
    @IBAction func quitAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCheckInAction(_ sender: Any) {
        
        if CLLocationManager.authorizationStatus() != .denied {
            self.locationManager.startUpdatingLocation()
            self.locationManager.delegate = self
        } else {
            let info = EVPopOverView(frame: CGRect(x: 0,y: 0,width: 300,height: 200), type: .info, icon: EVImage.ic_logo.icon(), title: "Thông báo", content: "Vui lòng bật định vị để thực hiện chức năng này")
            let controller = EVPopOverController(customView: info, height: info.heightView )
            controller.showView(self, detailBlock: nil) {
                controller.closeVC()
            }
        }
    }
    
    func showAlertCompleteTask(title: String = "Thông báo", subTitle: String = "", frame: CGRect = CGRect(x: 0,y: 0,width: 300,height: 200), type: EVPopOverAppearance = .info, icon: UIImage? = EVImage.ic_logo.icon() ) {
        let info = EVPopOverView(frame: frame, type: type, icon: icon, title: title, content: subTitle)
        let controller = EVPopOverController(customView: info, height: info.heightView )
        controller.showView(self, detailBlock: nil) {
            controller.closeVC()
        }
    }
    
    @IBAction func completeAction(_ sender: Any) {
        
        guard let task = task, let userEventId = self.userEventId else {
            self.showAlertCompleteTask(subTitle: "Thông tin không hợp lệ, vui lòng thực hiện lại sau")
            return
        }
        
        guard let myLocation = myLocation else {
            self.showAlertCompleteTask(subTitle: "Vui lòng check in vị trí bạn đang thực hiện nhiệm vụ")
            return
        }
        
        guard let imageSeleted = self.imageSeleted  else {
            self.showAlertCompleteTask(subTitle: "Vui lòng chụp ảnh để chúng tôi xác thực thông tin của bạn")
            return
        }
        
//        guard let idPost = self.idPost else {
//            self.showAlertCompleteTask(subTitle: "Bạn phải Chia sẻ Facebook dưới chế độ công khai nhiệm vụ này")
//            return
//
//        }
        
        self.showLoading() // 
        _ = EVAppFactory.client
            .tasks
            .uploadImage(image: imageSeleted, supplierId: task.supplier_id)
            .observeOn(MainScheduler.instance)
            .flatMap({ (result) -> Observable<EVResponseMission> in
                return EVAppFactory.client.tasks
                    .completeTask(task, userEventId: userEventId, linkPost: "", imageURL: result, location: myLocation)
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (response) in
                self.hideLoading()
                if case .failure(let message) = response {
                    self.showAlertCompleteTask(subTitle: message)
                } else { // success
//                    self.showAlertCompleteTask(subTitle: "Bạn đã hoàn thành nhiệm vụ")
                    let info = EVPopOverView(frame: CGRect(x: 0,y: 0,width: 300,height: 200), type: .info, icon: EVImage.ic_logo.icon(), title: "Thông Báo", content: "Bạn đã hoàn thành nhiệm vụ")
                    let controller = EVPopOverController(customView: info, height: info.heightView )
                    controller.showView(self, detailBlock: nil) {
                        controller.closeVC()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }, onError: { (error) in
                self.hideLoading()
                self.showAlertCompleteTask(subTitle: error.localizedDescription)
            })
        
    }
    
    
    @IBAction func shareFBAction(_ sender: Any) {
        
        if FBSDKAccessToken.current() == nil {
            showAlertCompleteTask(subTitle: "Bạn phải đăng nhập Facebook")
        } else {
            if imageSeleted != nil {
                
                    let sharePhoto = FBSDKSharePhoto(image: imageSeleted, userGenerated: true)
                    let content = FBSDKSharePhotoContent()
                    content.photos = [sharePhoto!]
//                    FBSDKShareDialog.show(from: self, with: content, delegate: self)
                    
                    
                    let shareDialog = FBSDKShareDialog()
                    shareDialog.mode = .browser
                    shareDialog.shareContent = content
                    shareDialog.delegate = self
                    shareDialog.fromViewController = self
                   
                    shareDialog.show()
                }else {
                    showAlertCompleteTask(subTitle: "Vui lòng chụp ảnh để chia sẻ")
                }
            }
    }
    
    
    func requestPublishPermissions(){
        
        let login: FBSDKLoginManager = FBSDKLoginManager()
        login.logIn(withPublishPermissions: ["publish_actions"], from: self) { (result, error) in
            if (error != nil) {
                print(error!)
            } else if (result?.isCancelled)! {
                print("Canceled")
            } else if (result?.grantedPermissions.contains("publish_actions"))! {
                print("permissions granted")
            }
        }
    }
}
extension EVCompleteTaskViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageSeleted = image
            contentImageView.image = imageSeleted
            dismiss(animated: true, completion: nil)
        }
    }
}

extension EVCompleteTaskViewController: CLLocationManagerDelegate {
    
    @objc(locationManager:didChangeAuthorizationStatus:) internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
            self.locationManager.delegate = self
        } else {
          
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        myLocation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.myLocation = location.coordinate
            self.locationManager.stopUpdatingLocation()
            self.locationManager.delegate = nil
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                var addressString : String = ""
                
                if error == nil && placemarks!.count > 0 {
                    let placemark = placemarks!.first!
                    if placemark.subThoroughfare != nil {
                        addressString = placemark.subThoroughfare! + " "
                    }
                    if placemark.thoroughfare != nil {
                        addressString = addressString + placemark.thoroughfare! + ", "
                    }
                    
                    if placemark.locality != nil {
                        addressString = addressString + placemark.locality! + ", "
                    }
                    if placemark.administrativeArea != nil {
                        addressString = addressString + placemark.administrativeArea! + " "
                    }
                    if placemark.country != nil {
                        addressString = addressString + placemark.country!
                    }
                    
                    dispatch_main_queue_safe {
                        self.labelAddress.text = addressString
                    }
                }
            })
        }
    }
}

extension EVCompleteTaskViewController: FBSDKSharingDelegate {
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        print(results)
        let data = JSON(results)
        self.idPost = data["postId"].stringValue
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        print(error)
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print()
    }
}
