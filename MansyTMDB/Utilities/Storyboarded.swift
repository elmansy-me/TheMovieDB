//
//  Storyboarded.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 25/11/2022.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

//MARK:- To Handle View Controller Initialization from Storyboard with name or directly from Xibs
extension Storyboarded where Self: UIViewController {
    static func instantiate(StoryboardName name: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
    
    static func instantiate() -> Self {
        let id = String(describing: self)
        let Nib = UINib(nibName: id, bundle: nil)
        return Nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
}


extension Storyboarded where Self: UICollectionViewController {
    static func instantiate(StoryboardName name: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
    
    static func instantiate() -> Self {
        let id = String(describing: self)
        let Nib = UINib(nibName: id, bundle: nil)
        return Nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
}
