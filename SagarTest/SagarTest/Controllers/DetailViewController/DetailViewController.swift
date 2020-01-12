//
//  DetailViewController.swift
//  demo
//
//  Created by Macmini3 on 10/01/20.
//  Copyright © 2020 Macmini3. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYears: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    var search:Modal.Search!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       lblTitle.text =  search.title
       lblType.text =  search.type
       posterImageView.sd_setImage(with: URL(string: search.poster.absoluteString), placeholderImage: UIImage(named: ""), options: .refreshCached, progress: nil, completed: nil)
        let Msg_Date_ = search.year
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd yyyy h:mm a"
        let datee = dateFormatterGet.date(from: Msg_Date_)
        if datee != nil {
            lblYears.text = self.timeAgoSinceDate(datee!, numericDates: false)
        }
    }


}
