//
//  VerticalMoviesViewController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 29/11/2022.
//

import UIKit
import MansyTMDBCore
import Combine

class VerticalMoviesViewController: BaseViewController {
    
    static func instantiate(dataSource: MoviesDatasource) -> Self {
        let vc = instantiate()
        vc.dataSource = dataSource
        return vc
    }
    
    @Published var data: [BaseMovieModel] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @Published var style: CollectionViewStyle = .grid
    
    var dataSource: MoviesDatasource?{
        didSet{
            bind()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    lazy var gridButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(switchUI))
    }()
    
    lazy var listButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(switchUI))
    }()
    
    @objc private func switchUI(){
        style.toggle()
    }
    
    func setupUI(){
        collectionView.register(UINib(nibName: GridMovieCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: GridMovieCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib(nibName: ListMovieCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ListMovieCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupNavigationItem(using style: CollectionViewStyle){
        navigationItem.rightBarButtonItem = style == .grid ? listButton : gridButton
        collectionView.reloadData()
    }
    
    func bind(){
        dataSource?.dataPublisher.sink(receiveValue: { [weak self] data in
            self?.data = data
        }).store(in: &subscriptions)
        
        $data.sink { [weak self] data in
            self?.collectionView.reloadData()
        }.store(in: &subscriptions)
        
        $style.sink { [weak self] data in
            self?.setupNavigationItem(using: data)
        }.store(in: &subscriptions)
        
        dataSource?.isLoadingPublisher.sink(receiveValue: { isLoading in
            isLoading ? LoadingManager().start() : LoadingManager().stop()
        }).store(in: &subscriptions)
        
        dataSource?.errorPublisher.sink(receiveValue: { [weak self] error in
            guard let error else{return}
            self?.showAlert(title: "Error", body: error, actions: [.close {
                self?.navigationController?.popViewController(animated: true)
            }])
        }).store(in: &subscriptions)
    }

}

extension VerticalMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            dataSource?.getMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch style{
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridMovieCollectionViewCell.reuseIdentifier, for: indexPath) as! GridMovieCollectionViewCell
            cell.configure(data: data[indexPath.item])
            return cell
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListMovieCollectionViewCell.reuseIdentifier, for: indexPath) as! ListMovieCollectionViewCell
            cell.configure(data: data[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch style{
        case .grid:
            let width = (collectionView.frame.width - 3 * 16) / 2
            return CGSize(width: width, height: 250)
        case .list:
            return CGSize(width: collectionView.frame.width - 2 * 16, height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
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
