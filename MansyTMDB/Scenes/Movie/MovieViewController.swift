//
//  MovieViewController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 29/11/2022.
//

import UIKit
import Combine
import MansyTMDBCore

class MovieViewController: BaseViewController {

    static func instantiate(repo: MovieRepository, data: BaseMovieModel) -> Self {
        let vc = instantiate()
        vc.title = data.title
        vc.viewModel = .init(repo: repo, id: data.id)
        return vc
    }
    
    var viewModel: MovieViewModel?{
        didSet{
            bindVM()
            viewModel?.getMovie()
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genresContainerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var productionCompaniesContainerView: UIView!
    
    lazy var genresViewController: GenresViewController = {
        GenresViewController.instantiate()
    }()
    
    lazy var productionCompaniesViewController: ProductionCompaniesViewController = {
        ProductionCompaniesViewController.instantiate()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI(){
        containerView.isHidden = true
        containerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        containerView.clipsToBounds = true
    }

    private func bindVM(){
        viewModel?.$data.sink(receiveValue: { [weak self] data in
            guard let data else{return}
            self?.setupUI(data: data)
        }).store(in: &subscriptions)
        
        viewModel?.$error.sink(receiveValue: { [weak self] error in
            guard let error else{return}
            self?.showAlert(title: error)
        }).store(in: &subscriptions)
        
        viewModel?.$isLoading.sink(receiveValue: { isLoading in
            isLoading ? LoadingManager().start() : LoadingManager().stop()
        }).store(in: &subscriptions)
    }
    
    private func setupUI(data: MovieModel){
        containerView.isHidden = false
        imageView.setImage(url: data.imageURL(quality: .medium), placeholder: .placeholder , config: .init(isDownsamplingEnabled: true))
        nameLabel.text = data.original_title
        descriptionLabel.text = data.overview
        ratingLabel.text = String(data.vote_average)
        voteCountLabel.text = [String(data.vote_count), "person rated this movie"].joined(separator: " ")
        genresViewController.data = data.genres
        add(asChildViewController: genresViewController, to: genresContainerView)
        
        if let status = data.status, let releaseDate = data.release_date{
            informationLabel.text = [status, "at", releaseDate].joined(separator: " ")
            informationLabel.superview?.isHidden = false
        }else{
            informationLabel.superview?.isHidden = true
        }
        
        if !data.production_companies.isEmpty{
            productionCompaniesContainerView.superview?.isHidden = false
            productionCompaniesViewController.data = data.production_companies
            add(asChildViewController: productionCompaniesViewController, to: productionCompaniesContainerView)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewDidPress))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func imageViewDidPress(){
        if let image = imageView.image{
            let vc = MovieRouter.getDestination(.image(source: .image(data: image)))
            navigateTo(vc)
        }else if let path = viewModel?.data?.imageURL(quality: .large), let url = URL(string: path){
            let vc = MovieRouter.getDestination(.image(source: .url(data: url)))
            navigateTo(vc)
        }
    }

}
