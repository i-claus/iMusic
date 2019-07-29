//
//  TrackDetailPresenter.swift
//  iMusic
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation

class TrackDetailPresenter {
    
    private weak var view: TrackDetailViewInjection?
    private let track: TrackViewModel
    private let interactor: TrackDetailInteractorDelegate
   
    // MARK - Lifecycle
    init(view: TrackDetailViewInjection, track: TrackViewModel, allTracks: [TrackViewModel], navigationController: UINavigationController? = nil) {
        self.view = view
        self.track = track
        self.interactor = TrackDetailInteractor(track: track, allTracks: allTracks)
    }
    
}

// MARK: - PlayerManagerDelegate
extension TrackDetailPresenter: PlayerManagerDelegate {
    
    func didFinishPlaying() {
        interactor.nextTrack()
        guard let currentTrack = interactor.getCurrentTrack() else { return }
        view?.loadTrack(currentTrack)
    }
    
    func currentTime(_ seconds: Int) {
        view?.loadCurrentTime(seconds)
    }
    
    func totalSecondsDuration(_ seconds: Double) {
        view?.loadCurrentTime(0)
        view?.loadTotalDuration(seconds)
    }
    
}

// MARK: - TrackDetailPresenterDelegate
extension TrackDetailPresenter: TrackDetailPresenterDelegate {
    
    func viewDidLoad() {
        PlayerManager.shared.delegate = self
        view?.loadTrack(track)
    }
    
    func viewDidDisappear() {
        interactor.pauseTrack()
    }
    
    func playPressed() {
        interactor.playTrack()
    }
    
    func pausePressed() {
        interactor.pauseTrack()
    }
    
    func nextPressed() {
        interactor.nextTrack()
        guard let currentTrack = interactor.getCurrentTrack() else { return }
        view?.loadTrack(currentTrack)
    }
    
    func prevPressed() {
        interactor.prevTrack()
        guard let currentTrack = interactor.getCurrentTrack() else { return }
        view?.loadTrack(currentTrack)
    }
    
    func sharePressed() {
        guard let view = view as? UIViewController, let currentTrack = interactor.getCurrentTrack() else {
            return
        }
        var items: [Any] = ["Hey! I'm listening \(currentTrack.trackName) by \(currentTrack.artistName) using the iTunes API"]
        
        if let previewUrl = currentTrack.previewUrl {
            items.append("\(previewUrl.absoluteString)")
        }
        
        ShareManager.shared.share(items, from: view)
    }
    
}
