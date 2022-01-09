//
//  TabBarManager.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 09/01/2022.
//

import Foundation
import UIKit

final internal class TabBarManager: UITabBarController {

    let contentFactory = ContentFactory()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarLayout()
        setupViewControllers()
    }

    private func setupTabBarLayout() {
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
    }

    private func setupViewControllers() {
        let tabBarViewControllers = contentFactory.getTabBarItems()
        viewControllers = tabBarViewControllers
    }
}
