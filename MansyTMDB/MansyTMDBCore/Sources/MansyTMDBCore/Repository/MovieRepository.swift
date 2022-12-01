//
//  MovieRepository.swift
//  
//
//  Created by Ahmed Elmansy on 29/11/2022.
//

import Foundation
import Combine

public class MovieRepository {
        
    public init(){}
    
    public typealias MovieResponse = (_ data: MovieModel?, _ error: String?)->()
    
    var subscriptions: [AnyCancellable] = []
    
    public func details(id: Int, response: @escaping MovieResponse ) {
        let request = ApiManager().apiCall(endPoint: MovieEndPoint.details(id: id)) as Future<MovieModel?, Error>
        request.sink { completion in
            switch completion {
            case .failure(let error):
                response(nil, error.localizedDescription)
                break
            case .finished:
                break
            }
        } receiveValue: { result in
            if let data = result{
                response(data, nil)
            }else{
                response(nil, "Internal error occured")
            }
        }.store(in: &subscriptions)
    }
    
}
