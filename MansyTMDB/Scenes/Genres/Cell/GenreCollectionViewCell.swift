//
//  GenreCollectionViewCell.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit
import MansyTMDBCore

class GenreCollectionViewCell: UICollectionViewCell, ReusableView {

    static var font: UIFont{
        UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    @IBOutlet weak var label: UILabel!
    
    func configure(data: GenreModel){
        label.text = data.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = Self.font
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        label.textColor = UIColor.lightGray
        // Initialization code
    }

}
