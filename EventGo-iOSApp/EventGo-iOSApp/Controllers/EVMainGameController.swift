//
//  EVMainGameController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/1/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import GoogleMaps

class EVMainGameController: EVViewController {

    @IBOutlet var mainMapView: GMSMapView!
    var temp = 0
    var listMarker = [EVMarker]()
    var mainBottonModel: EVMainBottomModel!
    var buttonHomeView: EVHomeBottom!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMapView.delegate = self
        setupView()
        
        mainBottonModel = EVMainBottomModel(gameControler: self)
        buttonHomeView = EVHomeBottom(viewController: self)
        
        updateInfo()
    }
    
    func setupView(){
        let camera = GMSCameraPosition.camera(withLatitude: 10.756927 , longitude: 106.684670, zoom: 12.0)
        
//        let loaction = CLLocationCoordinate2D(latitude: 10.756927, longitude: 106.684670)
        let loaction = CLLocationCoordinate2D(latitude: 10.761369, longitude: 106.6801278)
        EVMakerManager.shareManager.mapView = mainMapView
        let locationSignal = EVClientService.shareInstance.getCurrentLocation(location: loaction)
        locationSignal.subscribeNext({ (listEvent) in
            let listLocation = listEvent as! [EVLocation]
            dispatch_main_queue_safe {
                for location in listLocation {
                    
                    if let infoLocation = location.location_info {
                        let temp = EVMarker(id: location.location_id , location: infoLocation.coordinate, title: location.name!, iconName: EVImage.ic_event.name())
                        EVMakerManager.shareManager.addMarker(temp)
                        self.listMarker.append(temp)
                    }
                }
            }
          
        }) { (error) in
            log.error(error)
        }

        
        self.mainMapView.camera = camera
    }
    
    func updateInfo() {
        
        let updateLocationSignal = EVLocationManager.share().didUpdateLocation()
        updateLocationSignal?.subscribeNext({ (object) in
            if let object = object as? CLLocation {
                dispatch_main_queue_safe {
                    GMSCameraPosition.camera(withLatitude: object.coordinate.latitude , longitude: object.coordinate.longitude, zoom: 13.0)
                }

            }
        }, error: { (error) in
            
        })
        
        let updateUserDevice = EVUserServices.shareInstance.updateUserDevice()
        updateUserDevice.subscribeNext({ (result) in
            if let result = result as? EVUpdateResult {
                
                log.info(result)
            }
        }, error: { (error) in
            log.error(error)
        })
    }
    
    func deletetMark() {
        
        let infoWindow = EVPopOverView(frame: CGRect(x: 0,y: 0,width: 300,height: 300), type: .fullInfo, icon: EVImage.ic_facebook.icon(), title: "Thông báo", content: "Chỉ mới chiếu đến tập thứ 3 nhưng “Sống chung với mẹ chồng” đã khiến khán giả sục sôi chờ đón từng tập. Theo đoàn làm phim thì tác phẩm không xây dựng “cuộc chiến” mẹ chồng nàng dâu nhằm gây ra những suy nghĩ trái chiều của khán giả đối với 2 người phụ nữ. Với “Sống chung với mẹ chồng”, mối quan hệ này không có “đúng – sai”, không có nhân vật “chính diện hay phản diện”. Bộ phim để cho khán giả tự mình lựa chọn họ sẽ đứng ở vị trí của bà mẹ chồng hay của cô con dâu, từ đó đưa ra cách nhìn và lối sống phù hợp.Tuy nhiên, khi")
        let controller = EVPopOverController(customView: infoWindow, height: infoWindow.heightView )
        controller.showView(self, detailBlock: nil) { 
            controller.closeVC()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension EVMainGameController: GMSMapViewDelegate {
    
    
        func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
       
            if let mark = listMarker.filter({$0.position.latitude == marker.position.latitude && $0.position.longitude == marker.position.longitude}).first {
             
                let infoWindow = EVPopOverView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), type: EVPopOverAppearance.info, icon: mark.icon! , title: marker.title!, content: "")
                let controller = EVPopOverController(customView: infoWindow, height: infoWindow.heightView )
                controller.showView(self, detailBlock: { (object) in
                    log.info(object)
                    self.dismiss(animated: true, completion: nil)
                }, cancelBlock: {
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
                
            }
            marker.title = ""
            return nil
        }

}
