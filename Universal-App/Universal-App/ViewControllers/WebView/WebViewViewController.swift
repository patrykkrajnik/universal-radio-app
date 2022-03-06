//
//  WebViewViewController.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 09/01/2022.
//

import Foundation
import UIKit

final internal class WebViewViewController: UIViewController {

    private let viewModel: WebViewViewModel

    init(viewModel: WebViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
    }

}
