//
//  MoviesListModel.swift
//  
//
//  Created by Ahmed Elmansy on 24/11/2022.
//

import Foundation

struct MoviesListModel: Codable{
    let page, total_pages, total_results: Int?
    let results: [BaseMovieModel]?
}
