//
//  MovieSearchCriteria.swift
//  
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import Foundation

public enum MovieSearchCriteria{
    
    case keyword(data: String)
    case genres(data: [GenreModel])
    
}
