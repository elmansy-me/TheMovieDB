//
//  ReusableView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 25/11/2022.
//

import Foundation

protocol ReusableView: AnyObject {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
