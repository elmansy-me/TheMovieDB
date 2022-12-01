//
//  ProductionCompanyCollectionViewCell.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit
import MansyTMDBCore

class ProductionCompanyCollectionViewCell: UICollectionViewCell, ReusableView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func configure(data: ProductionCompanyModel){
        imageView.setImage(url: data.imageURL(quality: .thumbnail), placeholder: .placeholder)
        label.text = data.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.backgroundColor = UIColor.lightGray
        // Initialization code
    }

}
