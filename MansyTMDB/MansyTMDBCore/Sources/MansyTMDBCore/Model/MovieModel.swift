//
//  File.swift
//  
//
//  Created by Ahmed Elmansy on 29/11/2022.
//

import Foundation

public struct MovieModel: Codable{
    public let id, vote_count: Int
    public let title, original_title, poster_path, overview, release_date, status: String?
    public let vote_average: Double
    public let genres: [GenreModel]
    public let adult: Bool
    public let production_companies: [ProductionCompanyModel]
    
    public func imageURL(quality: ImageResolution)-> String{
        guard let poster_path else{return ""}
        return ["http://image.tmdb.org/t/p/\(quality.size)", poster_path].joined(separator: "/")
    }
}
