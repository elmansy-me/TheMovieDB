//
//  PopularMoviesViewModel.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 24/11/2022.
//

import Foundation
import Combine
import MansyTMDBCore

protocol MoviesDatasource{
    var dataPublisher: Published<[BaseMovieModel]>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    var errorPublisher: Published<String?>.Publisher { get }
    func getMovies()
}
