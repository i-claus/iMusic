//
//  PlayerManager.swift
//  iMusic
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlayerManagerDelegate: class {
    func didFinishPlaying()
    func currentTime(_ seconds: Int)
    func totalSecondsDuration(_ seconds: Double)
}

class PlayerManager {
    
    public weak var delegate: PlayerManagerDelegate?
    
    private var observer: NSKeyValueObservation?
    private var player: AVPlayer?
    private var url: URL?
    
    var isPlaying: Bool {
        return player?.timeControlStatus == .playing
    }
    
    static let shared: PlayerManager = { return PlayerManager() }()
    
    public func prepare(with url: URL?) {
        guard let url = url else { return }
        
        self.url = url
        
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        
        // Register as an observer of the player item's status property
        self.observer = playerItem.observe(\.status, options:  [.new, .old], changeHandler: { (playerItem, change) in
            if playerItem.status == .readyToPlay {
                self.readyToPlay()
            }
        })
        
        player = AVPlayer(playerItem: playerItem)
    }
    
    public func play() {
        player?.play()
        
        self.player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main, using: { [weak self] (time) in
            guard let `self` = self else { return }
            self.processCurrentTime()
        })
    }
    
    public func pause() {
        player?.pause()
    }

}

extension PlayerManager {
    
    private func readyToPlay() {
        guard let player = player, let currentItem = player.currentItem else {
            return
        }
        delegate?.totalSecondsDuration(currentItem.duration.seconds)
    }
    
    @objc private func didFinishPlaying() {
        delegate?.didFinishPlaying()
    }
    
    private func processCurrentTime() {
        guard let player = player, let currentItem = player.currentItem else {
            return
        }
        
        if currentItem.status == .readyToPlay {
            let currentTime = CMTimeGetSeconds(player.currentTime())
            let secs = Int(currentTime)
            delegate?.currentTime(secs)
        }
    }
    
}
