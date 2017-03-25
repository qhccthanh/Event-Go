//
//  InfoAwardViewController.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/27/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit

class InfoAwardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAcceptAction(_ sender: Any) {
        let model = NotificatonModel(title: "THỬ THÁCH", nameImage: "", content: "Bạn sẽ trãi qua tất cả 4 thử thách từ chương trình", isShowExitButton: true, isShowHandleButton: false)
        let view = EVPopupView(frame: CGRect(x: 0, y: 0, width: 216, height: 100))
        view.show(with: model, type: .detail) {
            print("Đã bấm OK")
        }
    }
  
}
extension InfoAwardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? StoreCollectionViewCell {
            if (indexPath.row % 2 == 0){
            let itemEventCartoon = CartoonModel(nameEvent: "Circle K Thủ Đức", nameImageEvent: "pokemon_ic", numberStepEvent: 3)
                cell.bindingUI(itemEvent: itemEventCartoon)
            } else {
                cell.imageEvent.image = UIImage(named: "arrow")
            }
            return cell
        }
        
        return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let flow = collectionViewLayout as? UICollectionViewFlowLayout {
            if(indexPath.row  % 2 != 0){
            return CGSize(width: 20, height: collectionView.frame.height)
            }
        }
        return CGSize(width: 60, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

