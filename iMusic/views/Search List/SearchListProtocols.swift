//
//  SearchListProtocols.swift
//  iMusic
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation

// View / Presenter
protocol SearchListViewInjection : class {
    func showProgress(_ show: Bool, status: String)
    func showProgress(_ show: Bool)
    func showMessageWith(title: String, message: String, actionTitle: String)
    func loadTracks(_ viewModels: [TrackViewModel], fromBeginning: Bool)
    func loadSuggestions(_ suggestions: [SuggestionViewModel])
}

protocol SearchListPresenterDelegate : class {
    func viewDidLoad()
    func searchTrack(_ search: String?)
    func trackSelectedAt(_ index: Int)
    func getSuggestions()
    func suggestionSelectedAt(_ index: Int)
    func sortTracksBy(_ type: SortType)
}

// Presenter / Interactor

typealias TracksGetTracksCompletionBlock = (_ viewModel: [TrackViewModel]?, _ success: Bool, _ error: ResultError?) -> Void
typealias TrackListGetSuggestionsCompletionBlock = ([SuggestionViewModel]) -> Void

protocol SearchListInteractorDelegate : class {
    func getTracksList(search: String?, completion: @escaping TracksGetTracksCompletionBlock)
    func clear()
    func getTrackSelectedAt(_ index: Int) -> TrackViewModel?
    func getAllSuggestions(completion: @escaping TrackListGetSuggestionsCompletionBlock)
    func getSuggestionAt(index: Int) -> SuggestionViewModel?
    func getInitialSearch() -> String
    func sortTracksBy(_ sortType: SortType)
    func getLocalTracks() -> [TrackViewModel]
}

// Presenter / Router
protocol SearchListRouterDelegate : class {
    func showTrackDetail(_ track: TrackViewModel, allTracks: [TrackViewModel])
}
