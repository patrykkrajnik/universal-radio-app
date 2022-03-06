//
//  ContentFactory.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 09/01/2022.
//

import Foundation
import UIKit

internal enum ViewType: String, Decodable {
    case player = "player"
    case webview = "webview"
}

final internal class ContentFactory {

    private var itemsContent: [ItemsContentModel]?
    private let appCoordinator = AppCoordinator()

    init() {
        self.itemsContent = self.getApplicationContent()
    }

    internal func getTabBarItems() -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        guard let itemsContent = itemsContent else { return viewControllers }

        for itemContent in itemsContent {
            viewControllers.append(appCoordinator.startViewControllers(withContent: itemContent))
        }

        return viewControllers
    }

    private func getApplicationContent() -> [ItemsContentModel]? {
        guard let path = Bundle.main.path(forResource: "content", ofType: "json") else { return nil }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let dataContent = try JSONDecoder().decode([ItemsContentModel].self, from: data)
            return dataContent
        } catch {
            print("Parsing JSON file failed")
            return nil
        }
    }

}
