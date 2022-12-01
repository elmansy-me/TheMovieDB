//
//  ListMovieCollectionViewCell.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 29/11/2022.
//

import UIKit
import MansyTMDBCore

class ListMovieCollectionViewCell: UICollectionViewCell, ReusableView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        // Initialization code
    }
    
    func configure(data: BaseMovieModel){
        imageView.setImage(url: data.imageURL(quality: .thumbnail), placeholder: .placeholder, config: .init(isDownsamplingEnabled: true))
        nameLabel.text = data.title
        descriptionLabel.text = data.overview
        ratingLabel.text = String(data.vote_average)
    }

}
