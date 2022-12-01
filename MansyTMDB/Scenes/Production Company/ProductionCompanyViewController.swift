//
//  ProductionCompanyViewController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit
import MansyTMDBCore

class ProductionCompanyViewController: BaseViewController {

    static func instantiate(data: ProductionCompanyModel) -> Self {
        let vc = instantiate()
        vc.data = data
        return vc
    }
    
    private var data: ProductionCompanyModel?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originCountryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let data else{return}
        configure(data: data)
    }
    
    private func configure(data: ProductionCompanyModel){
        let imageURL = data.imageURL(quality: .medium)
        if imageURL.isEmpty{
            imageView.isHidden = true
        }else{
            imageView.isHidden = false
            imageView.setImage(url: imageURL, placeholder: UIImage(systemName: "photo.circle"))
        }
        nameLabel.text = data.name
        originCountryLabel.text = data.origin_country
        nameLabel.superview?.isHidden = data.name == nil
        originCountryLabel.superview?.isHidden = data.origin_country == nil
    }

}
