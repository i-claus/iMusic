//
//  GeneralMessageProtocols.swift
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation

// View / Presenter
protocol GeneralMessageViewInjection : class {
    func load(title: String, message: String)
}

protocol GeneralMessagePresenterDelegate : class {
    func viewDidAppear()
}
