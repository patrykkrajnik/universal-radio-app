//
//  WebViewCoordinator.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 06/03/2022.
//

import Foundation
import UIKit

final internal class WebViewCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let webViewViewModel = WebViewViewModel()
        let webViewViewController = WebViewViewController(viewModel: webViewViewModel)

        navigationController.pushViewController(webViewViewController, animated: true)
    }

}
