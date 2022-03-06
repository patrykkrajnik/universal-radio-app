//
//  AppCoordinator.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 06/03/2022.
//

import Foundation
import UIKit

final internal class AppCoordinator: BaseCoordinator {

    func start() {
        /* noop */
    }

    internal func startViewControllers(withContent itemContent: ItemsContentModel) -> UINavigationController {
        let navigationController = UINavigationController()

        switch itemContent.viewType {
        case .player:
            let radioPlayerCoordinator = RadioPlayerCoordinator(navigationController: navigationController)
            coordinate(to: radioPlayerCoordinator)
        case .webview:
            let webViewCoordinator = WebViewCoordinator(navigationController: navigationController)
            coordinate(to: webViewCoordinator)
        }

        navigationController.tabBarItem.title = itemContent.title

        return navigationController
    }

}
