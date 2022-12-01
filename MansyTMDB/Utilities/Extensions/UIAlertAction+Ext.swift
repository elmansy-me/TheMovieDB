//
//  UIAlertAction+Ext.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit

extension UIAlertAction{
    
    static func close(completion: @escaping ()->())->UIAlertAction{
        .init(title: "Close", style: .cancel){ _ in
            completion()
        }
    }
    
    static var close: UIAlertAction{
        .init(title: "Close", style: .cancel)
    }
    
}
