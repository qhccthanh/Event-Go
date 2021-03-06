//
//  EVMainGameController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/1/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift
import RxCocoa

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
        
        setupLocationUpdating()
        EVAppFactory.users.updateDeviceInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let policy = UserDefaults.standard.value(forKey: "isRead") as? Bool
        if policy == nil   {
            self.showAlertCompleteTask()
            UserDefaults.standard.set(true, forKey: "isRead")
//            return
        }
    }
    
    func showAlertCompleteTask(title: String = "Điều khoản", subTitle: String = "Ứng dụng EventGo chính sách: \r\n1. Phần thưởng và sự kiện được sự đảm bảo của EventGo và nhà tài trợ không phải là Apple.\r\n2. Việc trao phần thưởng sẽ do các nhà cung cấp quyết định.\r\n3. EventGo và nhà cung cấp sẽ chịu trách nhiệm bảo đảm thông tin người dùng.\r\n4. EventGo sẽ chịu trách nhiệm nếu phần thưởng có những vấn đề cần giải quyết.\r\n5. EventGo cũng như Apple sẽ không chịu trách nhiệm cho sự mất mát tài sản cá nhân khi tham gia sự kiện của người dùng bao gồm (Cướp giật, hư hỏng).\r\n6. EventGo sẽ mọi trách nhiệm về mặt pháp lý nếu xãy ra tranh chấp, kiện tụng\r\nMọi chi tiết liên hệ (+84) 1863210265\r\nEvent Go", frame: CGRect = CGRect(x: 0,y: 0,width: 330,height: 600), type: EVPopOverAppearance = .info, icon: UIImage? = EVImage.ic_logo.icon() ) {
        let info = EVPopOverView(frame: frame, type: type, icon: icon, title: title, content: subTitle)
        let controller = EVPopOverController(customView: info, height: info.heightView )
        controller.showView(self, detailBlock: nil) {
            controller.closeVC()
        }
    }

    
    func setupLocationUpdating() {
        
        EVLocationManager.share()
            .didUpdateLocation()
            .take(until: self.rac_willDeallocSignal())
            .subscribeNext({ (object) in
                if let object = object as? CLLocation {
                    
                    self.loadLocations(coordinate: object.coordinate)
                    dispatch_main_queue_safe {
                        GMSCameraPosition.camera(withTarget: object.coordinate, zoom: 14.0)
                    }
                }
            }, error: { (error) in
                
            })

    }
    
    func setupView() {
        let coordinate = CLLocationCoordinate2D(latitude: 10.756927, longitude: 106.684670)
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 14.0)
        EVMakerManager.shareManager.mapView = mainMapView
        self.mainMapView.camera = camera
    }
    
    func loadLocations(coordinate: CLLocationCoordinate2D) {
        _ = EVAppFactory.client
            .loadLocations(coordinate: coordinate)
            .observeOn(MainScheduler.instance)
            .takeUntil(self.rx.deallocating)
            .subscribe(onNext: { (locations) in
                for location in locations {
                    if let infoLocation = location.location_info {
                        var iconTemp = EVImage.ic_gift.name()
                        if location.name!.lowercased().contains("circle"){
                            iconTemp = EVImage.ic_circle.name()
                        }
                        if location.name!.lowercased().contains("mart"){
                            iconTemp = EVImage.ic_bsmart.name()
                        }
                        let temp = EVMarker(id: location.location_id , location: infoLocation.coordinate, title: location.name!, iconName: iconTemp)
                        EVMakerManager.shareManager.addMarker(temp)
                        self.listMarker.append(temp)
                    }
                }
            }, onError: { (error) in
                
            })
    }
    
    func deletetMark() {
        
        let infoWindow = EVPopOverView(frame: CGRect(x: 0,y: 0,width: 300,height: 300), type: .fullInfo, icon: EVImage.ic_facebook.icon()!, title: "Thông báo", content: "Chỉ mới chiếu đến tập thứ 3 nhưng “Sống chung với mẹ chồng” đã khiến khán giả sục sôi chờ đón từng tập. Theo đoàn làm phim thì tác phẩm không xây dựng “cuộc chiến” mẹ chồng nàng dâu nhằm gây ra những suy nghĩ trái chiều của khán giả đối với 2 người phụ nữ. Với “Sống chung với mẹ chồng”, mối quan hệ này không có “đúng – sai”, không có nhân vật “chính diện hay phản diện”. Bộ phim để cho khán giả tự mình lựa chọn họ sẽ đứng ở vị trí của bà mẹ chồng hay của cô con dâu, từ đó đưa ra cách nhìn và lối sống phù hợp.Tuy nhiên, khi")
        let controller = EVPopOverController(customView: infoWindow, height: infoWindow.heightView )
        controller.showView(self, detailBlock: nil) { 
            controller.closeVC()
        }
    }

}

extension EVMainGameController: GMSMapViewDelegate {
    
        func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
       
            if let mark = listMarker.filter({$0.position.latitude == marker.position.latitude && $0.position.longitude == marker.position.longitude}).first {
             
                let infoWindow = EVPopOverView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), type: EVPopOverAppearance.info, icon: mark.icon! , title: mark.title!, content: "")
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

