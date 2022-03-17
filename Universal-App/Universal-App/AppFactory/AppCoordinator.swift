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

    internal func startViewController(withContent itemContent: TabBarItemContentModel) -> UINavigationController {
        let navigationController = UINavigationController()

        switch itemContent.subItems.count {
        case 0:
            print("No data to create ViewController")
        case 1:
            createSingleViewController(navigationController, withContent: itemContent)
        default:
            createMultipleChoiceViewController(navigationController, withContent: itemContent)
        }

        navigationController.tabBarItem.title = itemContent.title

        return navigationController
    }

    private func createSingleViewController(
        _ navigationController: UINavigationController,
        withContent itemContent: TabBarItemContentModel
    ) {
        guard let initialData = itemContent.subItems.first else {
            /* noop */
            return
        }

        switch itemContent.viewType {
        case .player:
            let radioPlayerCoordinator = RadioPlayerCoordinator(
                initialData: initialData,
                navigationController: navigationController
            )
            coordinate(to: radioPlayerCoordinator)
        case .webview:
            let webViewCoordinator = WebViewCoordinator(
                initialData: initialData,
                navigationController: navigationController
            )
            coordinate(to: webViewCoordinator)
        }
    }

    private func createMultipleChoiceViewController(
        _ navigationController: UINavigationController,
        withContent itemContent: TabBarItemContentModel
    ) {
        print("Waiting for new ViewControllers to init")
    }

}
