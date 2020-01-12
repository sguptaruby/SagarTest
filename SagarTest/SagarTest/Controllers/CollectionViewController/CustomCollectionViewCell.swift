//
//  CustomCollectionViewCell.swift
//  demo
//
//  Created by Macmini3 on 10/01/20.
//  Copyright © 2020 Macmini3. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYears: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
