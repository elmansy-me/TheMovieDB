//
//  CollectionViewStyle.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 29/11/2022.
//

import Foundation

enum CollectionViewStyle{
    case grid, list
    
    mutating func toggle(){
        switch self {
        case .grid:
            self = .list
        case .list:
            self = .grid
        }
    }
}
