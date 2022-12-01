//
//  GenreModel.swift
//  
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import Foundation

struct GenresResponse: Codable{
    let genres: [GenreModel]
}

public struct GenreModel: Codable{
    public let id: Int
    public let name: String
}
