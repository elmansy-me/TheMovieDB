//
//  TopRatedMoviesDatasource.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 29/11/2022.
//

import Foundation
import Combine
import MansyTMDBCore

class TopRatedMoviesDatasource: BaseViewModel, MoviesDatasource{
    
    @Published var data: [BaseMovieModel] = []
    var dataPublisher: Published<[BaseMovieModel]>.Publisher { $data }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    var errorPublisher: Published<String?>.Publisher { $error }

    private var page: Int?
    private let repo: MoviesRepository
    @Published private var isLoading = false

    init(repo: MoviesRepository, page: Int = 1, data: [BaseMovieModel] = []){
        self.repo = repo
        self.page = page
        self.data = data
    }

    func getMovies(){
        guard !isLoading else{return}
        guard let page else{
            error = "No more available movies."
            return
        }
        isLoading = true
        repo.topRated(page: page) { data, error in
            self.isLoading = false
            if let data{
                if data.isEmpty{
                    self.page = nil
                }else{
                    self.page = (self.page ?? 0) + 1
                }
                self.data.append(contentsOf: data)
            }else{
                self.error = error
            }
        }
    }
    
}
