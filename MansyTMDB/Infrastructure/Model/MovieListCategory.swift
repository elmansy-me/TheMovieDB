//
//  MovieListCategory.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 29/11/2022.
//

import Foundation

enum MovieListCategory{
    case popular, topRated, upcoming
    
    var description: String{
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}
