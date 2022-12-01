//
//  HorizontalMoviesViewController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 25/11/2022.
//

import UIKit
import MansyTMDBCore
import Combine

class HorizontalMoviesViewController: BaseViewController {
    
    @Published var data: [BaseMovieModel] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        collectionView.register(UINib(nibName: GridMovieCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: GridMovieCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func bind(){
        $data.sink { [weak self] data in
            self?.collectionView.reloadData()
        }.store(in: &subscriptions)
    }

}

extension HorizontalMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridMovieCollectionViewCell.reuseIdentifier, for: indexPath) as! GridMovieCollectionViewCell
        cell.configure(data: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 250, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MoviesRouter().getViewController(.movie(data: data[indexPath.item]))
        navigateTo(vc)
    }
    
}
