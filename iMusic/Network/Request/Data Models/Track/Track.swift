//
//  Track.swift
//  iMusic
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation

public struct TracksResponse: Decodable {
    
    let resultCount: UInt
    let results: [TrackResponse]
    
}

public struct TrackResponse: Decodable {
    
    let artistName: String
    let trackId: Int
    let trackName: String
    let trackViewUrl: String
    let previewUrl: String?
    let artworkUrl100: String
    let releaseDate: String
    let primaryGenreName: String
    let trackPrice: Float?
    let currency: String
    let trackTimeMillis: Int?
    let collectionName: String?
    
}
