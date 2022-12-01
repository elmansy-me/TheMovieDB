//
//  GenresRepository.swift
//  
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import Foundation
import Combine

public class GenresRepository {
        
    public init(){}
    
    public typealias Response = (_ data: [GenreModel]?, _ error: String?)->()
    
    var subscriptions: [AnyCancellable] = []
    
    public func moviesGenres(response: @escaping Response ) {
        let request = ApiManager().apiCall(endPoint: GenresEndPoint.movieGenres) as Future<GenresResponse?, Error>
        request.sink { completion in
            switch completion {
            case .failure(let error):
                response(nil, error.localizedDescription)
                break
            case .finished:
                break
            }
        } receiveValue: { result in
            if let data = result?.genres{
                response(data, nil)
            }else{
                response(nil, "Internal error occured")
            }
        }.store(in: &subscriptions)
    }
    
}
