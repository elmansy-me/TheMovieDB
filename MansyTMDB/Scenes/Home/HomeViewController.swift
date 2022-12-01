//
//  HomeViewController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 24/11/2022.
//

import UIKit
import MansyTMDBCore

class HomeViewController: BaseViewController {
    
    static func instantiate(moviesRepo: MoviesRepository,
                            genresRepo: GenresRepository) -> Self {
        let vc = instantiate()
        vc.title = "Home"
        vc.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc.tabBarItem.image = UIImage(systemName: "house")
        vc.viewModel = .init(moviesRepo: moviesRepo, genresRepo: genresRepo)
        return vc
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var genresContainerView: UIView!
    @IBOutlet weak var popularContainerView: UIView!
    @IBOutlet weak var topRatedContainerView: UIView!
    @IBOutlet weak var upcomingContainerView: UIView!
    
    lazy var genresViewController: GenresViewController = {
        GenresViewController.instantiate()
    }()
    
    lazy var popularViewController: HorizontalMoviesViewController = {
        HorizontalMoviesViewController.instantiate()
    }()
    
    lazy var topRatedViewController: HorizontalMoviesViewController = {
        HorizontalMoviesViewController.instantiate()
    }()
    
    lazy var upcomingViewController: HorizontalMoviesViewController = {
        HorizontalMoviesViewController.instantiate()
    }()
    
    var viewModel: HomeViewModel?{
        didSet{
            bindVM()
            viewModel?.getData()
        }
    }
    
    @IBAction func seeAllPopularMoviesButton(_ sender: Any) {
        viewModel?.seeAll(of: .popular)
    }
    
    @IBAction func seeAllTopRatedMoviesButton(_ sender: Any) {
        viewModel?.seeAll(of: .topRated)
    }
    
    
    @IBAction func seeAllUpcomingMoviesButton(_ sender: Any) {
        viewModel?.seeAll(of: .upcoming)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
    }
    
}

extension HomeViewController{
    
    func setupRefreshControl() {
        // Add the refresh control to your UIScrollView object.
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action:
                                                #selector(handleRefreshControl),
                                             for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        viewModel?.getData()
    }
    
}

//MARK: Bind ViewModel

extension HomeViewController{
    
    func bindVM(){
        viewModel?.$genres.sink(receiveValue: { [weak self] data in
            self?.addGenres(data)
        }).store(in: &subscriptions)
        
        viewModel?.$popularMovies.sink(receiveValue: { [weak self] data in
            self?.addMovies(data, to: .popular)
        }).store(in: &subscriptions)
        
        viewModel?.$topRatedMovies.sink(receiveValue: { [weak self] data in
            self?.addMovies(data, to: .topRated)
        }).store(in: &subscriptions)
        
        viewModel?.$upcomingMovies.sink(receiveValue: { [weak self] data in
            self?.addMovies(data, to: .upcoming)
        }).store(in: &subscriptions)
        
        viewModel?.destinationViewController.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] vc in
            self?.navigateTo(vc)
        }).store(in: &subscriptions)
        
        viewModel?.$error.sink(receiveValue: { [weak self] error in
            guard let error else{return}
            self?.scrollView.refreshControl?.endRefreshing()
            self?.showAlert(title: error)
        }).store(in: &subscriptions)
        
        viewModel?.$isLoading.sink(receiveValue: { isLoading in
            isLoading ? LoadingManager().start() : LoadingManager().stop()
        }).store(in: &subscriptions)
    }
    
}


//MARK: Add Movie List to Container View

extension HomeViewController{
    
    private func addGenres(_ data: [GenreModel]){
        guard !data.isEmpty else{return}
        scrollView.refreshControl?.endRefreshing()
        genresContainerView.superview?.isHidden = false
        genresViewController.data = data
        add(asChildViewController: genresViewController, to: genresContainerView)
    }
    
    private func addMovies(_ data: [BaseMovieModel],to category: MovieListCategory){
        guard !data.isEmpty else{return}
        scrollView.refreshControl?.endRefreshing()
        let components: (view: UIView, vc:HorizontalMoviesViewController) = {
            switch category {
            case .popular:
                return (popularContainerView, popularViewController)
            case .topRated:
                return (topRatedContainerView, topRatedViewController)
            case .upcoming:
                return (upcomingContainerView, upcomingViewController)
            }
        }()
        components.view.superview?.isHidden = false
        add(asChildViewController: components.vc, to: components.view)
        components.vc.data = data
    }
    
}
