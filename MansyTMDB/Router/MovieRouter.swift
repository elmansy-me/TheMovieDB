//
//  MovieRouter.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit
import MansyTMDBCore

struct MovieRouter{
    
    enum Destination{
        case image(source: ImageSource)
    }
    
    static func getDestination(_ destination: Destination)-> UIViewController{
        switch destination{
        case .image(let source):
            return getImageViewController(source: source)
        }
    }
    
    static private func getImageViewController(source: ImageSource)-> UIViewController{
        let vc = ImageViewController.instantiate(source: source)
        return vc
    }
    
}
