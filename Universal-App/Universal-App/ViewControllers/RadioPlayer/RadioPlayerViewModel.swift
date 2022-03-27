//
//  RadioPlayerViewModel.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 06/03/2022.
//

import Foundation
import RxSwift
import RxCocoa
import FRadioPlayer

final internal class RadioPlayerViewModel {

    internal let data: ItemContentModel

    internal let playPauseDidTap = PublishSubject<Void>()

    private let artistTitleRelay = BehaviorRelay<String>(value: "")
    internal var artistTitle: Driver<String> {
        return artistTitleRelay.asDriver(onErrorJustReturn: "")
    }

    private let songTitleRelay = BehaviorRelay<String>(value: "")
    internal var songTitle: Driver<String> {
        return songTitleRelay.asDriver(onErrorJustReturn: "")
    }

    private let artworkImageUrlRelay = BehaviorRelay<URL?>(value: nil)
    internal var artworkImageUrl: Driver<URL?> {
        return artworkImageUrlRelay.asDriver(onErrorJustReturn: nil)
    }

    private let playerIsPlayingRelay = BehaviorRelay<Bool>(value: true)
    internal var playerIsPlaying: Driver<Bool> {
        return playerIsPlayingRelay.asDriver(onErrorJustReturn: false)
    }

    private let isLoadingRelay = BehaviorRelay<Bool>(value: true)
    internal var isLoading: Driver<Bool> {
        return isLoadingRelay.asDriver(onErrorJustReturn: true)
    }

    private let player = FRadioPlayer.shared
    private let disposeBag = DisposeBag()

    init(withInitialData data: ItemContentModel) {
        self.data = data

        setupRadioPlayer()
        setupActions()
    }

    private func setupActions() {
        playPauseDidTap
            .subscribe(with: self) { owner, _ in
                owner.player.isPlaying ? owner.player.pause() : owner.player.play()
            }
            .disposed(by: disposeBag)
    }

    private func setupRadioPlayer() {
        player.delegate = self
        player.radioURL = URL(string: data.url)
        player.artworkSize = 512
    }
}

extension RadioPlayerViewModel: FRadioPlayerDelegate {

    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        isLoadingRelay.accept(state != .loadingFinished ? true : false)
    }

    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        playerIsPlayingRelay.accept(state == .playing ? true : false)
    }

    func radioPlayer(_ player: FRadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
        guard let artistName = artistName else {
            artistTitleRelay.accept("")
            return
        }

        guard let trackName = trackName else {
            songTitleRelay.accept("")
            return
        }

        artistTitleRelay.accept(artistName)
        songTitleRelay.accept(trackName)
    }

    func radioPlayer(_ player: FRadioPlayer, artworkDidChange artworkURL: URL?) {
        guard let artworkURL = artworkURL else {
            artworkImageUrlRelay.accept(nil)
            return
        }

        artworkImageUrlRelay.accept(artworkURL)
    }

    func radioPlayer(_ player: FRadioPlayer, itemDidChange url: URL?) {
        /* noop */
    }

    func radioPlayer(_ player: FRadioPlayer, metadataDidChange rawValue: String?) {
        /* noop */
    }

}
