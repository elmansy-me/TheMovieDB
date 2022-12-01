//
//  ProductionCompanyModel.swift
//  
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import Foundation

public struct ProductionCompanyModel: Codable{
    public let id: Int
    public let name, logo_path, origin_country: String?
    
    public func imageURL(quality: ImageResolution)-> String{
        guard let logo_path else{return ""}
        return ["http://image.tmdb.org/t/p/\(quality.size)", logo_path].joined(separator: "/")
    }
}
