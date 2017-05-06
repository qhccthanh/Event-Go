//
//  CellModel.swift
//  FOODO
//
//  Created by Nguyen Xuan Thai on 2/12/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit

// Các protocol nhớ tách ra các file riêng

// Đăt tên đừng có specific cho 1 cái gì quá 
// Protocol thì đặt tên chung chung thôi vì nó có thể dùng cho nhiều loại khác nhau chứ không phải nameEvent hoặc Event kế thừa lại 1 cái chung
//

// VD ở đây TTItemProtocol là lớp protocol bindingUI cao nhất 
// *** Nhớ kế thừa : NSObjectProtocol để có 1 số phương thức và thuộc tính cơ bản...
// TT ở đầu tên class gọi la prefix name thường sẽ là tên của ứng dụng tổ chức cá nhân VD: Các SDK của Apple thường là UI VD: UITableView (UI là UIKit)
// VD sau này t mún làm cho 1 model khác t có thể kế thừa lại cái TTItemProtocol này hoặc tạo 1 protocol khác kế thừa TTItemProtocol này để mở rộng.
protocol TTItemProtocol: NSObjectProtocol {
    
    // ở đây các phương thức nên để overview nhất (tông quan nhất) để dùng cho nhiều thứ chứ không nhất thiết là Event
//    func nameEvent() -> String
//    func imageEvent() -> UIImage?
//    func numberStepEvent() -> String?
    
    func titleItem() -> String
    
    func imageItem() -> UIImage?
    
    func subTitleItem() -> String?
}

extension TTItemProtocol {
    
    func imageItem() -> UIImage? {
        return nil
    }
    
    func subTitleItem() -> String? {
        return nil
    }
}

// Nếu chỉ riêng cho event (Event có nhiều loại) thì tạo 1 cái class cho Event
// Ở đây có thể có thêm vài thuộc tính #
protocol ItemEventProtocol: TTItemProtocol {
    
    // VD Event có thêm 1 trường khác cần để bindingUI cần impletion là state
//    func stateItem() -> Bool
    
}

protocol ItemPopupProtocol: TTItemProtocol {
    func isShowExitButton() -> Bool
    func isShowHandleButton() -> Bool
}

class EVMarkerModel: NSObject, ItemPopupProtocol {
    
    var title: String?
    var imageName: String?
    var descriptionPlace: String?
    var showHandleButton: Bool!
    func imageItem() -> UIImage? {
        return UIImage(named: imageName ?? "place")
    }
    
    init(name: String, imageName: String, descriptionPlace: String, showHandleButton: Bool = false) {
        self.title = name
        self.imageName = imageName
        self.descriptionPlace = descriptionPlace
        self.showHandleButton = showHandleButton
        
    }
    
    func titleItem() -> String {
        return title ?? ""
    }
    
    func subTitleItem() -> String? {
        return descriptionPlace
    }
    
    func isShowExitButton() -> Bool {
       return true
    }
    
    func isShowHandleButton() -> Bool {
       return showHandleButton
    }
}

class NotificatonModel: NSObject, ItemPopupProtocol {
    
    var isExitButton: Bool!
    var isHandleButton: Bool!
    var title: String?
    var content: String?
    var nameImage: String?
    
    init(title: String?, nameImage: String?, content: String, isShowExitButton: Bool, isShowHandleButton: Bool) {
        
        self.title = title
        self.content = content
        self.nameImage = nameImage
        self.isExitButton = isShowExitButton
        self.isHandleButton = isShowHandleButton
        
        super.init()
    }
    
    // MARK: delegate of ItemPopupProtocol
    
    func titleItem() -> String {
        return title ?? "Đây là title"
    }
    
    func subTitleItem() -> String? {
        return content
    }
    
    func imageItem() -> UIImage? {
        return UIImage(named: self.nameImage!) ?? EVImage.ic_check.icon()
    }
    
    func isShowExitButton() -> Bool {
        return self.isExitButton
    }
    
    func isShowHandleButton() -> Bool {
        return self.isHandleButton
    }
}

class CartoonModel: NSObject, ItemEventProtocol {
    
    var nameItemEvent: String!
    var nameImageEvent: String!
    var numberStep: Int?
    
    init(nameEvent: String, nameImageEvent: String, numberStepEvent: Int) {
        
        self.nameItemEvent = nameEvent
        self.nameImageEvent = nameImageEvent
        self.numberStep = numberStepEvent
        
        // Nhớ gọi super init để có những thuộc tính cần thiết của NSCopy hay Descrpition ...cần
        super.init()
    }
    
    func titleItem() -> String {
        return nameItemEvent
    }
    
    func imageItem() -> UIImage? {
        return UIImage(named: nameImageEvent) ?? EVImage.ic_logo.icon()
    }
    
    func subTitleItem() -> String? {
        return "\(numberStep ?? 0)"
    }
}

