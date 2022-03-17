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
    private let data: ItemContentModel

    init(
        initialData data: ItemContentModel,
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        self.data = data
    }

    func start() {
        let radioPlayerViewModel = RadioPlayerViewModel(withInitialData: data)
        let radioPlayerViewController = RadioPlayerViewController(viewModel: radioPlayerViewModel)

        navigationController.pushViewController(radioPlayerViewController, animated: true)
    }
    
}
