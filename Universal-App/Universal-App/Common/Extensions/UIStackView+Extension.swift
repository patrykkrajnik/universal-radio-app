//
//  UIStackView+Extension.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 05/03/2022.
//

import Foundation
import UIKit

internal enum Spacing: CGFloat {
    case large = 15.0
    case basic = 10.0
    case small = 5.0
    case none = 0.0
}

extension UIStackView {

    convenience init(
        axis: NSLayoutConstraint.Axis,
        spacing: Spacing = .none,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) {
        self.init()
        self.axis = axis
        self.spacing = spacing.rawValue
        self.alignment = alignment
        self.distribution = distribution
    }

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
