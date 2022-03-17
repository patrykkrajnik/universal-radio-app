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

    private var tabBarItemsContent: [TabBarItemContentModel]?
    private let appCoordinator = AppCoordinator()

    init() {
        self.tabBarItemsContent = self.getApplicationContent()
    }

    internal func getTabBarItems() -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        guard let tabBarItemsContent = tabBarItemsContent else { return viewControllers }

        for tabBarItemContent in tabBarItemsContent {
            viewControllers.append(appCoordinator.startViewController(withContent: tabBarItemContent))
        }

        return viewControllers
    }

    private func getApplicationContent() -> [TabBarItemContentModel]? {
        guard let path = Bundle.main.path(forResource: "content", ofType: "json") else { return nil }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let dataContent = try JSONDecoder().decode([TabBarItemContentModel].self, from: data)
            return dataContent
        } catch {
            print("Parsing JSON file failed")
            return nil
        }
    }

}
