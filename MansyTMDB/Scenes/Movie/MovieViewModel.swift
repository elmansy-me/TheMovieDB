//
//  MovieViewModel.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 29/11/2022.
//

import Foundation
import Combine
import MansyTMDBCore

class MovieViewModel: BaseViewModel{
    
    @Published var data: MovieModel?
    @Published var isLoading = false
    
    private var id: Int
    private let repo: MovieRepository

    init(repo: MovieRepository, id: Int){
        self.repo = repo
        self.id = id
    }

    func getMovie(){
        guard !isLoading else{
            return
        }
        isLoading = true
        repo.details(id: id) { data, error in
            self.isLoading = false
            if let data{
                self.data = data
            }else{
                self.error = error
            }
        }
    }
    
}
