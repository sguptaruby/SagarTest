//
//  CollectionViewController.swift
//  demo
//
//  Created by Macmini3 on 10/01/20.
//  Copyright © 2020 Macmini3. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewController: UIViewController {
    
    /// Outlets
    @IBOutlet weak var collectionVW:UICollectionView!
    let viewModal = ViewModal()
    var modalData:Modal?

    /// view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionVW.delegate = self
        collectionVW.dataSource = self
        collectionVW.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        apiCalled()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func apiCalled() {
        self.showHUD()
        viewModal.getData { (bool, data, error) in
            self.hideHUD()
            if error == nil {
                print(data!)
                if let dict = data {
                    self.modalData = Modal(json: dict)
                    self.collectionVW.reloadData()
                }
            }else{
                self.showAlertView(message: "No data found.")
            }
        }
    }
    
    func showAlertView(message:String)  {
        let alertView = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
        
    }
    
   

}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension CollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.modalData != nil {
            return self.modalData?.search.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionVW.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        if let data = modalData {
             cell.lblTitle.text =  data.search[indexPath.item].title
             cell.lblType.text =  data.search[indexPath.item].type
            cell.posterImageView.sd_setImage(with: URL(string: data.search[indexPath.item].poster.absoluteString), placeholderImage: UIImage(named: ""), options: .refreshCached, progress: nil, completed: nil)
            let Msg_Date_ = data.search[indexPath.item].year
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd yyyy h:mm a"
            let datee = dateFormatterGet.date(from: Msg_Date_)
            if datee != nil {
                cell.lblYears.text = self.timeAgoSinceDate(datee!, numericDates: false)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = modalData {
            let detailsViewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
            detailsViewController.search = data.search[indexPath.item]
               self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}

extension CollectionViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
