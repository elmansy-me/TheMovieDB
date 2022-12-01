//
//  HomeRouter.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit
import MansyTMDBCore

struct HomeRouter{
    
    enum Destination{
        case seeAll(category: MovieListCategory, datasource: MoviesDatasource)
    }
    
    static func getDestination(_ destination: Destination)-> UIViewController{
        switch destination{
        case .seeAll(let category, let datasource):
            return getMoviesViewController(category: category, datasource: datasource)
        }
    }
    
    static private func getMoviesViewController(category: MovieListCategory, datasource: MoviesDatasource)-> UIViewController{
        let vc = VerticalMoviesViewController.instantiate(dataSource: datasource)
        vc.title = category.description
        return vc
    }
    
}
