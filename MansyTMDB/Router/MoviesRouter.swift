//
//  MoviesRouter.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit
import MansyTMDBCore

struct MoviesRouter: Router{
    
    enum Destination{
        case movie(data: BaseMovieModel)
    }
    
    func getViewController(_ destination: Destination)-> UIViewController{
        switch destination{
        case .movie(let data):
            return getDestination(data: data)
        }
    }
    
    private func getDestination(data: BaseMovieModel)-> UIViewController{
        let vc = MovieViewController.instantiate(repo: MovieRepository(), data: data)
        return vc
    }
    
}
