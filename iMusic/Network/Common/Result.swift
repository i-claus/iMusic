//
//  Result.swift
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(ResultError)
}
