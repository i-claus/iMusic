//
//  TrackDetailRouter.swift
//  iMusic
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation
import SafariServices

class TrackDetailRouter {
    
    private weak var navigationController: UINavigationController?
    
    // MARK - Lifecycle
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    /**
     * Setup the initial module
     */
    public static func setupModuleWithCurrentTrack(_ track: TrackViewModel, allTracks: [TrackViewModel], navigationController: UINavigationController?) -> TrackDetailViewController {
        let trackDetailVC = TrackDetailViewController()
        trackDetailVC.presenter = TrackDetailPresenter(view: trackDetailVC, track: track, allTracks: allTracks, navigationController: navigationController)
        return trackDetailVC
    }
    
}
