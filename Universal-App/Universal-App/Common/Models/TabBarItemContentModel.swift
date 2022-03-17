//
//  TabBarItemContentModel.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 09/01/2022.
//

import Foundation

internal struct TabBarItemContentModel: Decodable {
    let title: String
    let icon: String
    let viewType: ViewType
    let subItems: [ItemContentModel]
}
