//
//  EVMainGameController.swift
//  EventGo-iOSApp
//
//  Created by Nguyen Xuan Thai on 4/1/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit
import GoogleMaps

class EVMainGameController: UIViewController {

    @IBOutlet var mainMapView: GMSMapView!
    var temp = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMapView.delegate = self
        let camera = GMSCameraPosition.camera(withLatitude: 10.756927 , longitude: 106.684670, zoom: 13.0)
        
        let loaction = CLLocationCoordinate2D(latitude: 10.756927, longitude: 106.684670)
        let loaction1 = CLLocationCoordinate2D(latitude: 10.761369, longitude: 106.6801278)
        let evMarker = EVMarker(id: "1", location: loaction, title: "EV1", iconName: "ic_pagoda")
        let evMarker1 = EVMarker(id: "2", location: loaction1, title: "EV2", iconName: "ic_pagoda")
        EVMakerManager.shareManager.mapView = mainMapView
        EVMakerManager.shareManager.addMarker(evMarker)
        EVMakerManager.shareManager.addMarker(evMarker1)
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
            button.titleLabel?.text = "xoa"
            button.layer.backgroundColor = UIColor.red.cgColor
        button.addTarget(self, action: #selector(self.deletetMark), for: .touchUpInside)
        mainMapView.addSubview(button)
        
        self.mainMapView.camera = camera
        let updateLocationSignal = EVLocationManager.share().didUpdateLocation()
        updateLocationSignal?.subscribeNext({ (object) in
            if let object = object as? CLLocation {
                GMSCameraPosition.camera(withLatitude: object.coordinate.latitude , longitude: object.coordinate.longitude, zoom: 13.0)
            }
        }, error: { (error) in
            
        })
    }
    
    func deletetMark() {
        let infoWindow = EVPopOverView(frame: CGRect(x: 0,y: 0,width: 300,height: 280), title: "Thông báo", content: "Chỉ mới chiếu đến tập thứ 3 nhưng “Sống chung với mẹ chồng” đã khiến khán giả sục sôi chờ đón từng tập. Theo đoàn làm phim thì tác phẩm không xây dựng “cuộc chiến” mẹ chồng nàng dâu nhằm gây ra những suy nghĩ trái chiều của khán giả đối với 2 người phụ nữ. Với “Sống chung với mẹ chồng”, mối quan hệ này không có “đúng – sai”, không có nhân vật “chính diện hay phản diện”. Bộ phim để cho khán giả tự mình lựa chọn họ sẽ đứng ở vị trí của bà mẹ chồng hay của cô con dâu, từ đó đưa ra cách nhìn và lối sống phù hợp.Tuy nhiên, khi ")
        let controller = EVPopOverController(customView: infoWindow, height: infoWindow.heightView )
        controller.showView(self, detailBlock: { (object) in
            log.info(object)
        }, cancelBlock: {
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension EVMainGameController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
         let infoWindow = EVPopOverView(frame: CGRect(x: 0,y: 0,width: 300,height: 280), title: "Thông báo", content: "Chỉ mới chiếu đến tập thứ 3 nhưng “Sống chung với mẹ chồng” đã khiến khán giả sục sôi chờ đón từng tập. Theo đoàn làm phim thì tác phẩm không xây dựng “cuộc chiến” mẹ chồng nàng dâu nhằm gây ra những suy nghĩ trái chiều của khán giả đối với 2 người phụ nữ. Với “Sống chung với mẹ chồng”, mối quan hệ này không có “đúng – sai”, không có nhân vật “chính diện hay phản diện”. Bộ phim để cho khán giả tự mình lựa chọn họ sẽ đứng ở vị trí của bà mẹ chồng hay của cô con dâu, từ đó đưa ra cách nhìn và lối sống phù hợp.Tuy nhiên, khi ")
        
        return infoWindow
    }
}
