//
//  GenresEndPoint.swift
//  
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

enum GenresEndPoint: BaseEndPointProtocol{

    case movieGenres

    var httpMethod: HttpMethod{
        .get
    }

    var parameters: [String : Any]?{
        switch self {
        case .movieGenres:
            return [
                "api_key": MansyTMDBCore.APIKey
            ]
        }
    }

    var path: String{
        switch self {
        case .movieGenres:
            return "genre/movie/list"
        }
    }


}
