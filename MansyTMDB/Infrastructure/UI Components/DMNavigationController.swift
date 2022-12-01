//
//  DMNavigationController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit

class DMNavigationController: UINavigationController {
    
    var lightModeBackgroundColor: UIColor = UIColor.label
    var darkModeBackgroundColor: UIColor = UIColor.label.inverted

    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.updateBarTintColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.updateBarTintColor()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateBarTintColor()
    }
    
    private func updateBarTintColor() {
        navigationBar.standardAppearance.backgroundColor = UITraitCollection.current.userInterfaceStyle == .dark ? darkModeBackgroundColor : lightModeBackgroundColor
        navigationBar.scrollEdgeAppearance?.backgroundColor = UITraitCollection.current.userInterfaceStyle == .dark ? darkModeBackgroundColor : lightModeBackgroundColor
        navigationBar.barTintColor = UITraitCollection.current.userInterfaceStyle == .dark ? darkModeBackgroundColor : lightModeBackgroundColor
    }
}
