//
//  RadioPlayerViewController.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 09/01/2022.
//

import Foundation
import UIKit

final internal class RadioPlayerViewController: UIViewController {

    private let stackView = UIStackView(
        axis: .vertical,
        spacing: .basic,
        alignment: .center
    )

    private let songTitle = UILabel()
    private let artistTitle = UILabel()

    private let artworkImageView = UIImageView()
    private let buttonImageView = UIImageView()

    private let playPauseButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func bindViewModel() {

    }

}

// MARK: - Setup UI
private extension RadioPlayerViewController {
    var availableHeight: CGFloat {
        return UIScreen.main.bounds.height - 100
    }

    var availableWidth: CGFloat {
        return UIScreen.main.bounds.width - 100
    }

    func setupUI() {
        setupSubviews()
        setupProperties()
        setupConstraints()
    }

    func setupSubviews() {
        view.addSubview(stackView)

        stackView.addArrangedSubviews([
            artworkImageView,
            songTitle,
            artistTitle,
            buttonImageView
        ])
    }

    func setupProperties() {
        let buttonImageViewCornerRadius: CGFloat = (availableWidth / 3.5) / 2
        let songTitleFontSize: CGFloat = availableWidth / 14
        let artistTitleFontSize: CGFloat = availableWidth / 20

        view.backgroundColor = .systemBackground

        songTitle.font = UIFont.systemFont(ofSize: songTitleFontSize, weight: .bold)
        songTitle.textAlignment = .center

        artistTitle.font = UIFont.systemFont(ofSize: artistTitleFontSize, weight: .regular)
        artistTitle.textAlignment = .center

        songTitle.text = "Title"
        artistTitle.text = "Artist"

        artworkImageView.backgroundColor = .green

        buttonImageView.backgroundColor = .gray
        buttonImageView.layer.cornerRadius = buttonImageViewCornerRadius
    }

    func setupConstraints() {
        let spacing: CGFloat = availableHeight / 10
        let artworkImageViewSize: CGFloat = availableWidth * 0.95
        let buttonImageViewSize: CGFloat = availableWidth / 3.5

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: spacing),
            stackView.widthAnchor.constraint(equalToConstant: availableWidth),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            artworkImageView.widthAnchor.constraint(equalToConstant: artworkImageViewSize),
            artworkImageView.heightAnchor.constraint(equalToConstant: artworkImageViewSize),

            songTitle.widthAnchor.constraint(equalToConstant: availableWidth),
            artistTitle.widthAnchor.constraint(equalToConstant: availableWidth),

            buttonImageView.widthAnchor.constraint(equalToConstant: buttonImageViewSize),
            buttonImageView.heightAnchor.constraint(equalToConstant: buttonImageViewSize)
        ])

        stackView.setCustomSpacing(spacing, after: artworkImageView)
        stackView.setCustomSpacing(spacing, after: artistTitle)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        songTitle.translatesAutoresizingMaskIntoConstraints = false
        artistTitle.translatesAutoresizingMaskIntoConstraints = false
        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
    }
}
