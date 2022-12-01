//
//  GenresRouter.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit
import MansyTMDBCore

struct GenresRouter{
    
    enum Destination{
        case movies(genres: [GenreModel])
    }
    
    static func getDestination(_ destination: Destination)-> UIViewController{
        switch destination{
        case .movies(let genres):
            return getDestination(genres: genres)
        }
    }
    
    static private func getDestination(genres: [GenreModel])-> UIViewController{
        let datasource = SearchMoviesDatasource(repo: MoviesRepository())
        datasource.criteria = .genres(data: genres)
        let vc = VerticalMoviesViewController.instantiate(dataSource: datasource)
        vc.title = genres.map{ $0.name }.joined(separator: ", ")
        return vc
    }
    
}
