//
//  InfoAwardViewController.swift
//  EventGo
//
//  Created by Nguyen Xuan Thai on 2/27/17.
//  Copyright © 2017 Nguyen Xuan Thai. All rights reserved.
//

import UIKit

class EVInfoAwardViewController: EVViewController {
    
    @IBOutlet weak var imageMainAward: UIImageView!
    @IBOutlet weak var nameMainAward: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listAward: [EVAward]?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.modalTransitionStyle = .coverVertical
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard listAward != nil  else {return}
        guard listAward?.count != 0  else {return}
        let mainAward = listAward!.first
        nameMainAward.text = mainAward!.name
        if let url = URL(string: mainAward!.image_url!) {
            imageMainAward.af_setImage(withURL: url)
        } else {
            imageMainAward.image = EVImage.ic_logo.icon()
        }
        
        self.listAward!.remove(at: 0)
        
        
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
            log.info("Đã bấm OK")
        }
    }
  
}
extension EVInfoAwardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard listAward != nil else {return 0}
        return listAward!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = listAward![indexPath.row]
        let model = EVAwardModel(award: item)
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EVListAwardsCollectionViewCell {
            cell.binding(item: model)
            
//            cell.bindingUI(itemEvent: <#T##ItemEventProtocol#>)
            return cell
        }
        
        return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
}

