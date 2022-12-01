//
//  NavigationController+Builder.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit

class NavigationContollerBuilder{
    
    private init(){}
    
    static func build(
        rootViewController: UIViewController,
        config: Config = Config()
    )-> UINavigationController{
        let nvc = DMNavigationController(rootViewController: rootViewController)
        nvc.lightModeBackgroundColor = config.backgroundColor
        nvc.darkModeBackgroundColor = config.backgroundColor.inverted
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = config.backgroundColor
        appearance.titleTextAttributes = [
            .foregroundColor: config.titleColor,
            .font: config.titleFont,
        ]
        nvc.navigationBar.barTintColor = config.backgroundColor
        nvc.navigationBar.tintColor = config.titleColor
        nvc.navigationBar.standardAppearance = appearance
        nvc.navigationBar.scrollEdgeAppearance = nvc.navigationBar.standardAppearance
        nvc.navigationBar.prefersLargeTitles = config.prefersLargeTitles
        return nvc
    }
    
    struct Config{
        let backgroundColor: UIColor
        let titleColor: UIColor
        let titleFont: UIFont
        let prefersLargeTitles: Bool
        
        init(
            backgroundColor: UIColor = UIColor.label.inverted,
            titleColor: UIColor = UIColor.label,
            titleFont: UIFont = .systemFont(ofSize: 17, weight: .semibold),
            prefersLargeTitles: Bool = false
        ) {
            self.backgroundColor = backgroundColor
            self.titleColor = titleColor
            self.titleFont = titleFont
            self.prefersLargeTitles = prefersLargeTitles
        }
        
    }
    
}
