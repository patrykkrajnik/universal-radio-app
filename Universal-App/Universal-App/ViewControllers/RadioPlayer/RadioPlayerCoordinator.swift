//
//  RadioPlayerCoordinator.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 06/03/2022.
//

import Foundation
import UIKit

final internal class RadioPlayerCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let radioPlayerViewModel = RadioPlayerViewModel()
        let radioPlayerViewController = RadioPlayerViewController(viewModel: radioPlayerViewModel)

        navigationController.pushViewController(radioPlayerViewController, animated: true)
    }
    
}
