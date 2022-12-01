//
//  SearchMoviesViewController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit
import MansyTMDBCore

class SearchMoviesViewController: BaseViewController, UISearchResultsUpdating {
    
    lazy var resultsViewController: VerticalMoviesViewController = {
        VerticalMoviesViewController.instantiate(dataSource: datasource)
    }()
    
    lazy var searchController: UISearchController = {
        UISearchController(searchResultsController: resultsViewController)
    }()
    
    lazy var datasource: SearchMoviesDatasource = {
        SearchMoviesDatasource(repo: MoviesRepository())
    }()
    
    @IBOutlet weak var placeholderView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTargets()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        resultsViewController.style = .list
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else{return}
        datasource.criteria = .keyword(data: text)
    }
    
    func addTargets(){
        searchController.searchBar.searchTextField.addTarget(self, action: #selector(shouldHidePlaceholderView), for: .editingDidBegin)
        searchController.searchBar.searchTextField.addTarget(self, action: #selector(shouldShowPlaceholderView), for: .editingDidEnd)
    }
    
    @objc func shouldHidePlaceholderView(){
        UIView.animate(withDuration: 1) { [weak self] in
            self?.placeholderView.alpha = 0
        }
    }
    @objc func shouldShowPlaceholderView(){
        UIView.animate(withDuration: 1) { [weak self] in
            self?.placeholderView.alpha = 1
        }
    }

}
