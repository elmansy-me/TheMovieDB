//
//  MoviesListEndPoint.swift
//
//
//  Created by Ahmed Elmansy on 24/11/2022.
//

import Foundation

enum MoviesListEndPoint: BaseEndPointProtocol{

    case popular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    case search(keyword: String, page: Int)
    case searchUsingGenres(genres: [GenreModel], page: Int)

    var httpMethod: HttpMethod{
        .get
    }

    var parameters: [String : Any]?{
        switch self {
        case .popular(let page):
            return [
                "page": page,
                "api_key": MansyTMDBCore.APIKey
            ]
        case .topRated(let page):
            return [
                "page": page,
                "api_key": MansyTMDBCore.APIKey
            ]
        case .upcoming(let page):
            return [
                "page": page,
                "api_key": MansyTMDBCore.APIKey
            ]
        case .search(let keyword, let page):
            return [
                "query": keyword,
                "page": page,
                "api_key": MansyTMDBCore.APIKey
            ]
        case .searchUsingGenres(let genres, let page):
            return [
                "with_genres": genres.map{ String($0.id) }.joined(separator: ","),
                "page": page,
                "api_key": MansyTMDBCore.APIKey
            ]
        }
    }

    var path: String{
        switch self {
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .search:
            return "search/movie"
        case .searchUsingGenres:
            return "discover/movie"
        }
    }


}
