//
//  MoviesRepository.swift
//  
//
//  Created by Ahmed Elmansy on 24/11/2022.
//

import Foundation
import Combine

public class MoviesRepository {
        
    public init(){}
    
    public typealias MoviesResponse = (_ data: [BaseMovieModel]?, _ error: String?)->()
    
    var subscriptions: [AnyCancellable] = []
    
    public func popular(page: Int, response: @escaping MoviesResponse ) {
        requestMovies(using: ApiManager().apiCall(endPoint: MoviesListEndPoint.popular(page: page))) { data, error in
            response(data, error)
        }
    }
    
    public func topRated(page: Int, response: @escaping MoviesResponse ) {
        requestMovies(using: ApiManager().apiCall(endPoint: MoviesListEndPoint.topRated(page: page))) { data, error in
            response(data, error)
        }
    }
    
    public func upcoming(page: Int, response: @escaping MoviesResponse ) {
        requestMovies(using: ApiManager().apiCall(endPoint: MoviesListEndPoint.upcoming(page: page))) { data, error in
            response(data, error)
        }
    }
    
    public func search(criteria: MovieSearchCriteria, page: Int, response: @escaping MoviesResponse ) {
        let endPoint: BaseEndPointProtocol? = {
            switch criteria {
            case .keyword(let data):
                guard !data.isEmpty else{return nil}
                return MoviesListEndPoint.search(keyword: data, page: page)
            case .genres(let data):
                return MoviesListEndPoint.searchUsingGenres(genres: data, page: page)
            }
        }()
        guard let endPoint else{
            response([], nil)
            return
        }
        requestMovies(using: ApiManager().apiCall(endPoint: endPoint)) { data, error in
            response(data, error)
        }
    }
    
}



extension MoviesRepository{
    
    private func requestMovies(using request: Future<MoviesListModel, Error>, response: @escaping MoviesResponse){
        request.sink { completion in
            switch completion {
            case .failure(let error):
                response(nil, error.localizedDescription)
                break
            case .finished:
                break
            }
        } receiveValue: { result in
            if let data = result.results{
                response(data, nil)
            }else{
                response(nil, "Internal error occured")
            }
        }.store(in: &subscriptions)
    }
    
}
