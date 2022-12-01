//
//  GridMovieCollectionViewCell.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 25/11/2022.
//

import UIKit
import MansyTMDBCore

class GridMovieCollectionViewCell: UICollectionViewCell, ReusableView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        // Initialization code
    }
    
    func configure(data: BaseMovieModel){
        imageView.setImage(url: data.imageURL(quality: .small))
        nameLabel.text = data.title
        ratingLabel.text = String(data.vote_average)
    }

}
