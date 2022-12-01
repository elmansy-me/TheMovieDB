//
//  HomeViewModel.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 25/11/2022.
//

import Foundation
import Combine
import MansyTMDBCore
import UIKit

class HomeViewModel: BaseViewModel{
    
    @Published var genres: [GenreModel] = []
    @Published var popularMovies: [BaseMovieModel] = []
    @Published var topRatedMovies: [BaseMovieModel] = []
    @Published var upcomingMovies: [BaseMovieModel] = []
    @Published var isLoading: Bool = false
    
    let destinationViewController = PassthroughSubject<UIViewController, Error>()

    private let moviesRepo: MoviesRepository
    private let genresRepo: GenresRepository

    init(moviesRepo: MoviesRepository,
         genresRepo: GenresRepository){
        self.moviesRepo = moviesRepo
        self.genresRepo = genresRepo
    }
        
    func getData(){
        isLoading = true
        getGenres()
        getPopularMovies()
        getTopRatedMovies()
        getUpcomingMovies()
    }
    
    private func getPopularMovies(){
        moviesRepo.popular(page: 1) { [weak self] data, error in
            self?.isLoading = false
            if let data{
                self?.popularMovies = data
            }else{
                self?.error = error
            }
        }
    }
    
    private func getTopRatedMovies(){
        moviesRepo.topRated(page: 1) { [weak self] data, error in
            self?.isLoading = false
            if let data{
                self?.topRatedMovies = data
            }else{
                self?.error = error
            }
        }
    }
    
    private func getUpcomingMovies(){
        moviesRepo.upcoming(page: 1) { [weak self] data, error in
            self?.isLoading = false
            if let data{
                self?.upcomingMovies = data
            }else{
                self?.error = error
            }
        }
    }
    
    private func getGenres(){
        genresRepo.moviesGenres { [weak self] data, error in
            self?.isLoading = false
            if let data{
                self?.genres = data
            }else{
                self?.error = error
            }
        }
    }
    
    func seeAll(of category: MovieListCategory){
        let initialData = getCurrentMovies(of: category)
        let initialPage = initialData.isEmpty ? 1 : 2
        let datasource = getDatasource(of: category, initalPage: initialPage, initialData: initialData)
        let vc = HomeRouter().getViewController(.seeAll(category: category, datasource: datasource))
        self.destinationViewController.send(vc)
    }
    
    private func getDatasource(of category: MovieListCategory, initalPage page: Int, initialData: [BaseMovieModel])-> MoviesDatasource{
        let repo = MoviesRepository()
        switch category {
        case .popular:
            return PopularMoviesDatasource(repo: repo, page: page, data: initialData)
        case .topRated:
            return TopRatedMoviesDatasource(repo: repo, page: page, data: initialData)
        case .upcoming:
            return UpcomingMoviesDatasource(repo: repo, page: page, data: initialData)
        }
    }
    
    private func getCurrentMovies(of category: MovieListCategory)-> [BaseMovieModel]{
        switch category {
        case .popular:
            return popularMovies
        case .topRated:
            return topRatedMovies
        case .upcoming:
            return upcomingMovies
        }
    }
    
}
