//
//  EVCompleteTaskViewController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 5/16/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import SystemConfiguration

class EVCompleteTaskViewController: EVViewController {

    @IBOutlet weak var chooseImageView: DashView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var labelAddress: UILabel!
    
    
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
