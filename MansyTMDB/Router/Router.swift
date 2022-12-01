//
//  Router.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 01/12/2022.
//

import UIKit

protocol Router{
    associatedtype Destination
    func getViewController(_ destination: Destination)-> UIViewController
}
