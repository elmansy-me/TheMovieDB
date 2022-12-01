//
//  UIViewController+Ext.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 25/11/2022.
//

import UIKit

extension UIViewController {
    
    func add(asChildViewController viewController: UIViewController, to view: UIView) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
