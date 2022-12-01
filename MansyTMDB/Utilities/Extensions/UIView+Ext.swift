//
//  UIView+Ext.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 29/11/2022.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get{
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}
