//
//  BaseCoordinator.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 06/03/2022.
//

import Foundation

protocol BaseCoordinator {
    func start()
    func coordinate(to coordinator: BaseCoordinator)
}

extension BaseCoordinator {
    func coordinate(to coordinator: BaseCoordinator) {
        coordinator.start()
    }
}
