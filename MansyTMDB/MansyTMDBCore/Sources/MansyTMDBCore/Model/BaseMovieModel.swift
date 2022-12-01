//
//  BaseMovieModel.swift
//  
//
//  Created by Ahmed Elmansy on 24/11/2022.
//

import Foundation

public struct BaseMovieModel: Codable{
    public let id: Int
    public let title, original_title, poster_path, overview: String?
    public let genre_ids: [Int]
    public let vote_average: Double
    
    public func imageURL(quality: ImageResolution)-> String{
        guard let poster_path else{return ""}
        return ["http://image.tmdb.org/t/p/\(quality.size)", poster_path].joined(separator: "/")
    }
}
