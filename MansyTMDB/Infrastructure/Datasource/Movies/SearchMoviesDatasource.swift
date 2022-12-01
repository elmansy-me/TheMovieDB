//
//  SearchMoviesDatasource.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import Foundation
import Combine
import MansyTMDBCore

class SearchMoviesDatasource: BaseViewModel, MoviesDatasource{
    
    @Published var data: [BaseMovieModel] = []
    var dataPublisher: Published<[BaseMovieModel]>.Publisher { $data }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    var errorPublisher: Published<String?>.Publisher { $error }

    private var page: Int?
    private let repo: MoviesRepository
    @Published private var isLoading = false

    @Published var criteria: MovieSearchCriteria?
    private var subscriptions: [AnyCancellable] = []

    init(repo: MoviesRepository, page: Int = 1){
        self.repo = repo
        self.page = page
        super.init()
        bind()
    }
    
    private func bind(){
        $criteria.sink { [weak self] criteria in
            self?.reset()
            self?.getMovies()
        }.store(in: &subscriptions)
    }
    
    private func reset(){
        page = 1
        data.removeAll()
    }

    func getMovies(){
        guard let criteria else{
            reset()
            return
        }
        switch criteria {
        case .keyword(let data):
            if data.isEmpty{
                reset()
            }
        default:
            break
        }
        
        guard !isLoading else{return}
        guard let page else{
            error = "No more available movies."
            return
        }
        
        isLoading = true
        repo.search(criteria: criteria, page: page) { data, error in
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
