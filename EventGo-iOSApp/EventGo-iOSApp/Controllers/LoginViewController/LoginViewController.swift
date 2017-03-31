//
//  LoginViewController.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/23/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import ReactiveCocoa
import ReactiveSwift

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let gradient: CAGradientLayer = CAGradientLayer()
//        let colorTop = UIColor(red: 235/255.0, green: 253.0/255.0, blue: 244.0/255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 250/255.0, green: 255.0/255.0, blue: 209.0/255.0, alpha: 1.0).cgColor
//        gradient.frame = self.view.bounds
//        gradient.colors = [colorTop, colorBottom]
//        gradient.locations = [0.0 , 1.0]
//        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
//        self.view.layer.insertSublayer(gradient, at: 0)
        // VD Lang nghe 1 thuoc tinh thay doi
        // dung tam vay 
        // vd cho nay truyen bien thi sao 
        // No1 phải thuộc về 1 đối tượng nào đó. Vd view nằm trong self
//        self.rac_values(forKeyPath: "value", observer: self).subscribeNext { (newValue) in
//            /...
//        }
        let temp = EVUser()
        temp.rac_values(forKeyPath: "user_id", observer: temp).subscribeNext { (newValue) in
            // .. new value o day
        }
        // Như ngày xưa mún làm 2 cái down load 
        // ý m là ngày xưa dùng dispach group rồi notify đúng kg ? ukm ngo`ai ra c`on phải truyền block rất mệt
        // BH chỉ cần tra ra c´ai RÁCignal
        // chỗ này thì t hiểu nhưng mà ứng dụng cái này có gì nhiều kg ?
        // Nhiều 
        // Đọc đi t chỉ nˆeu 2 -3 vd thˆoi 
        // N´o c´o thể lắng nghe thay đổi rồi mẻge lại 
        // VD : From nhập thogn6 tin m` muốn thằng kia n´o nhập tất cả c´ac ô dữ liệu rồi mới enable button th`i m` l`am ntn ?
        // ngày xưa thì phải check hết từng giá trị của text box thôi => implement delegate của tẽtfield đúng k bắt 
        // bắt khi c´o thay đỏi th`i check 
        
        
        // BH VD 
//        let textField1: UITextField = UITextField()
//        let textField2: UITextField = UITextField()
//        let textField3: UITextField = UITextField()
//        var button = UIButton()
//        RAC(self, createEnabled) = [RACSignal
//            combineLatest:@[ RACObserve(self, password), RACObserve(self, passwordConfirmation) ]
//            reduce:^(NSString *password, NSString *passwordConfirm) {
//            return @([passwordConfirm isEqualToString:password]);
//            }];
        // Chiu kho vao2 doc no' doc them. T k the~ chi~ luon nay` dc
//        Signal.combineLatest([textField1.reactive.textValues,
//                              textField2.reactive.textValues,
//                              textField3.reactive.textValues
//                              ]).reduce(_) { (_, texts) -> Bool in
//                                
//        } ~> button.isEnabled
        // Cai co ban~ hay dung nhat nam' 2 cai'.
        // Khi SDK t tra ve` cai RacSignal thi` subscribe no VD o duoi ham dang nhap fb
        // 2 Khi co nhieu` task can` hoan` thanh` thi` dung2 merge
        // 3 Khi can` lang nghe thay doi~ tu` 1 key nao do
        // 4 Cac extension cua~ vai uikit VD  ?? Label, textfield, button
        
        UIButton().reactive.controlEvents(.touchUpInside).observe({
            _ in
            // bat su kien toch up inside
        })
        
        // Nhiều cái nữa t cũng chưa bít 
        // nhuwng ma t hoi cho nay 
        // nếu nó làm dc cái touch up inside thì mình đâu cần kéo action của nó ?
        // Ukm nhiều c´ai # nữa 
        
        // ok để t tim hiểu cái này cho
        // T`im hiểu kỉ đừng c´o qua loa
        
        // T`im hiểu cở 1 buổi rồi l`am c´ai đăng nhập xem
        // Reduce d`ung để
        // Hàm trên có nghĩa là 1 trong 3 thằng đó thay đổi thì sẽ gọi vào block
        // ủa chứ k phải so sánh 3 giá trị trong textfield đó à ?
        // Nó lỗi qua h` dùng tạm cái reactswift vs reactcoca
        //uwmf
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func loginFaceBookAction(_ sender: Any) {
        // Chi vay
     
        
    
        
    }
    
    
//    func getResponse() -> RACSignal<AnyObject>{
////        return RACSignal.createSignal({
////            (subscribe) -> RACDisposable? in
////            
////            let networkSingal = EVNetworkManager.sharedInstance().request(withPath: "/abc", parameters: [:], requestEventId: 1)
////            networkSingal?.subscribeNext({ (response) in
////                let data = response
////                subscribe.sendNext(data)
////            }, error: { (error) in
////                subscribe.sendError(error)
////            })
////            return nil
////        })
//    }
    
    @IBAction func loginGoogleAction(_ sender: Any) {
       
    }
}
