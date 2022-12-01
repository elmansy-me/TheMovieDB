//
//  GenresViewController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit
import MansyTMDBCore
import Combine

class GenresViewController: BaseViewController {
    
    @Published var data: [GenreModel] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        collectionView.register(UINib(nibName: GenreCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: GenreCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func bind(){
        $data.sink { [weak self] data in
            self?.collectionView.reloadData()
        }.store(in: &subscriptions)
    }

}

extension GenresViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.reuseIdentifier, for: indexPath) as! GenreCollectionViewCell
        cell.configure(data: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: GenreCollectionViewCell.font]
        let size = data[indexPath.item].name.size(withAttributes: fontAttributes)
        return CGSize(width: size.width + 10, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = GenresRouter.getDestination(.movies(genres: [ data[indexPath.item] ]))
        navigateTo(vc)
    }
    
}
