//
//  TabBarController+Builder.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import UIKit

class TabBarControllerBuilder{
    
    private init(){}
    
    static func build(
        viewControllers: [UIViewController] = [],
        config: Config = Config()
    )-> UITabBarController{
        let tvc = UITabBarController()
        tvc.viewControllers = viewControllers
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = config.backgroundColor
            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: config.titleColor,
                .font: config.selectedFont,
            ]
            let unselectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: config.unselectedColor,
                .font: config.unselectedColor,
            ]
            tvc.tabBar.tintColor = config.titleColor
            tvc.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
            tvc.tabBarItem.setTitleTextAttributes(unselectedAttributes, for: .normal)
            tvc.tabBar.unselectedItemTintColor = config.unselectedColor
            tvc.tabBarItem.standardAppearance = appearance
            tvc.tabBarItem.scrollEdgeAppearance = tvc.tabBarItem.standardAppearance
        }
        return tvc
    }
    
    struct Config{
        let backgroundColor: UIColor
        let titleColor: UIColor
        let selectedFont: UIFont
        let unselectedFont: UIFont
        let unselectedColor: UIColor
        
        init(
            backgroundColor: UIColor = UIColor.label.inverted,
            titleColor: UIColor = UIColor.label,
            selectedFont: UIFont = .systemFont(ofSize: 15, weight: .semibold),
            unselectedFont: UIFont = .systemFont(ofSize: 15, weight: .regular),
            unselectedColor: UIColor = UIColor.label.withAlphaComponent(0.7)
        ) {
            self.backgroundColor = backgroundColor
            self.titleColor = titleColor
            self.selectedFont = selectedFont
            self.unselectedFont = unselectedFont
            self.unselectedColor = unselectedColor
        }
        
    }
    
}
