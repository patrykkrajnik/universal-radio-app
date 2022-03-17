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
    private let data: ItemContentModel

    init(
        initialData data: ItemContentModel,
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        self.data = data
    }

    func start() {
        let webViewViewModel = WebViewViewModel(withInitialData: data)
        let webViewViewController = WebViewViewController(viewModel: webViewViewModel)

        navigationController.pushViewController(webViewViewController, animated: true)
    }

}
