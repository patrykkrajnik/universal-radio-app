//
//  RadioPlayerViewController.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 09/01/2022.
//

import Foundation
import UIKit
import RxSwift
import SDWebImage

final internal class RadioPlayerViewController: UIViewController {

    private let viewModel: RadioPlayerViewModel

    private let stackView = UIStackView(
        axis: .vertical,
        spacing: .basic,
        alignment: .center
    )

    private let activityIndicator = UIActivityIndicatorView()

    private let songTitleLabel = UILabel()
    private let artistTitleLabel = UILabel()

    private let artworkImageView = UIImageView()
    private let buttonImageView = UIImageView()
    private let playPauseButton = UIButton()

    private let disposeBag = DisposeBag()

    init(viewModel: RadioPlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func bindViewModel() {
        navigationItem.title = viewModel.data.title

        playPauseButton.rx.tap
            .bind(to: viewModel.playPauseDidTap)
            .disposed(by: disposeBag)

        viewModel.artistTitle
            .drive(with: self, onNext: { owner, artistTitle in
                owner.artistTitleLabel.text = artistTitle.handleIfEmpty()
            })
            .disposed(by: disposeBag)

        viewModel.songTitle
            .drive(with: self, onNext: { owner, songTitle in
                owner.songTitleLabel.text = songTitle.handleIfEmpty()
            })
            .disposed(by: disposeBag)

        viewModel.artworkImageUrl
            .drive(with: self, onNext: { owner, artworkUrl in
                guard let artworkUrl = artworkUrl else {
                    owner.artworkImageView.image = nil
                    return
                }
                owner.artworkImageView.sd_setImage(with: artworkUrl, completed: nil)
            })
            .disposed(by: disposeBag)

        viewModel.playerIsPlaying
            .drive(with: self, onNext: { owner, isPlaying in
                owner.buttonImageView.backgroundColor = isPlaying ? .red : .blue
            })
            .disposed(by: disposeBag)

        viewModel.isLoading
            .drive(with: self, onNext: { owner, isLoading in
                isLoading ? owner.activityIndicator.startAnimating() : owner.activityIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
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
        artworkImageView.addSubview(activityIndicator)
        playPauseButton.addSubview(buttonImageView)

        stackView.addArrangedSubviews([
            artworkImageView,
            songTitleLabel,
            artistTitleLabel,
            playPauseButton
        ])
    }

    func setupProperties() {
        let buttonImageViewCornerRadius: CGFloat = (availableWidth / 3.5) / 2
        let songTitleFontSize: CGFloat = availableWidth / 14
        let artistTitleFontSize: CGFloat = availableWidth / 20

        view.backgroundColor = .systemBackground

        songTitleLabel.font = UIFont.systemFont(ofSize: songTitleFontSize, weight: .bold)
        songTitleLabel.textAlignment = .center

        artistTitleLabel.font = UIFont.systemFont(ofSize: artistTitleFontSize, weight: .regular)
        artistTitleLabel.textAlignment = .center

        artworkImageView.backgroundColor = .green
        artworkImageView.contentMode = .scaleAspectFit

        playPauseButton.backgroundColor = .gray
        playPauseButton.layer.cornerRadius = buttonImageViewCornerRadius
    }

    func setupConstraints() {
        let spacing: CGFloat = availableHeight / 10
        let artworkImageViewSize: CGFloat = availableWidth * 0.95
        let buttonImageViewSize: CGFloat = availableWidth / 3.5

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: spacing / 2),
            stackView.widthAnchor.constraint(equalToConstant: availableWidth),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            artworkImageView.widthAnchor.constraint(equalToConstant: artworkImageViewSize),
            artworkImageView.heightAnchor.constraint(equalToConstant: artworkImageViewSize),

            activityIndicator.centerXAnchor.constraint(equalTo: artworkImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: artworkImageView.centerYAnchor),

            songTitleLabel.widthAnchor.constraint(equalToConstant: availableWidth),
            artistTitleLabel.widthAnchor.constraint(equalToConstant: availableWidth),

            playPauseButton.widthAnchor.constraint(equalToConstant: buttonImageViewSize),
            playPauseButton.heightAnchor.constraint(equalToConstant: buttonImageViewSize),

            buttonImageView.widthAnchor.constraint(equalToConstant: buttonImageViewSize / 2),
            buttonImageView.heightAnchor.constraint(equalToConstant: buttonImageViewSize / 2),
            buttonImageView.centerXAnchor.constraint(equalTo: playPauseButton.centerXAnchor),
            buttonImageView.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor)
        ])

        stackView.setCustomSpacing(spacing, after: artworkImageView)
        stackView.setCustomSpacing(spacing, after: artistTitleLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        artistTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
    }
}
