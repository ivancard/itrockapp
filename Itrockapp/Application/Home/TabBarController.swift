//
//  TabBarController.swift
//  Itrockapp
//
//  Created by Ivan Cardenas on 23/01/2023.
//

import UIKit

enum TabIndex {
    case profile
    case home
}

final class TabBarController: UITabBarController {
    
    var indexTabBar : TabIndex = .home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .gray
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = .clear
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.Poppins.regular(withSize: 10)],
            for: .normal)
        
        let profile = UINavigationController(rootViewController: MainProfileViewController())
        let home = UINavigationController(rootViewController: HomeViewController())
        self.viewControllers = [home, profile]
  
       
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        switch indexTabBar {
        case .home:
            selectedIndex =  0
        case .profile:
            selectedIndex =  1
        }
    }
}
