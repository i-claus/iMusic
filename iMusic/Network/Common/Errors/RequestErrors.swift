//
//  RequestErrors.swift
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation

struct RequestErrorResponse: Decodable {
    let errors: [[String:String]]
    
    var parsedErrors: [RequestError] {
        let flattenedDictionary = errors
            .flatMap { $0 }
            .reduce([String:String]()) { (dict, tuple) in
                var nextDict = dict
                nextDict.updateValue(tuple.1, forKey: tuple.0)
                return nextDict
        }
        return flattenedDictionary.compactMap({
            return RequestError(key: $0.0, error: $0.1)
        })
    }
    
    var reason: String? {
        return parsedErrors.filter{ $0.key == "reason" }.first?.error
    }
}

struct RequestError: Decodable {
    let key: String
    let error: String
    
    init(key: String, error: String) {
        self.key = key
        self.error = error
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        let dict = try container.decode([String:String].self)
        guard let key = dict.first?.key,
            let value = dict.first?.value else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Could not parse error from server")
        }
        self.key = key
        self.error = value
    }
}

enum FieldErrorResponseState: String, Decodable {
    case missing
    case invalid
}
