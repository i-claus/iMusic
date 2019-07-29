//
//  EndPoint.swift
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import UIKit

protocol EndpointProtocol: RawRepresentable where RawValue == String {
    var url: URL? { get }
}

/**
 * Internal struct for Url
 */
private struct Url {
    
    static let baseUrl: String = "https://itunes.apple.com/search"
    
    struct Fields {
        static let term: String = "term"
        static let media: String = "media"
        static let entity: String = "entity"
        static let attribute: String = "attribute"
        static let limit: String = "limit"
    }
    
    struct Parameters {
        static let limit: UInt = 20
        static let music: String = "music"
    }
    
}

// MARK: - Endpoints
enum Endpoint: EndpointProtocol {
    
    var rawValue: String {
        switch self {
        case .getArtistWith(let search):
            var endpoint = "?\(Url.Fields.media)=\(Url.Parameters.music)&\(Url.Fields.limit)=\(Url.Parameters.limit)"
            
            if let search = search, let searchWithUrlFormat = search.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                endpoint = "\(endpoint)&\(Url.Fields.term)=\(searchWithUrlFormat)"
            }
            
            return endpoint
        }
    }
    
    case getArtistWith(search: String?)
    
}

extension EndpointProtocol {
    
    init?(rawValue: String) {
        assertionFailure("init(rawValue:) not implemented")
        return nil
    }
    
    var url: URL? {
        let urlComponents = URLComponents(string: Url.baseUrl + self.rawValue)
        return urlComponents?.url
    }
    
}
