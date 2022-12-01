//
//  ProductionCompaniesViewController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit
import MansyTMDBCore
import Combine

class ProductionCompaniesViewController: BaseViewController {
    
    @Published var data: [ProductionCompanyModel] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        collectionView.register(UINib(nibName: ProductionCompanyCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductionCompanyCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func bind(){
        $data.sink { [weak self] data in
            self?.collectionView.reloadData()
        }.store(in: &subscriptions)
    }
    
}

extension ProductionCompaniesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductionCompanyCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductionCompanyCollectionViewCell
        cell.configure(data: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        32
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = data[indexPath.item]
        let vc = ProductionCompanyRouter().getViewController(.details(data: data))
        present(vc, animated: true)
    }
    
}
