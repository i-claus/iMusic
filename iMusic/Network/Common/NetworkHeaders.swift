//
//  NetworkHeaders.swift
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation

final class NetworkHeaders {
    
    private enum Keys {
        static let authorizationKey = "Authorization"
    }
    
    static func create() -> [AnyHashable: Any] {
        
        let headers: [AnyHashable: Any] = [:]
        return headers
        
    }
}
