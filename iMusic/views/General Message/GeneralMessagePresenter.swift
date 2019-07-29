//
//  GeneralMessagePresenter.swift
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation

enum GeneralMessageType {
    case NoInternetConnection
}

class GeneralMessagePresenter {
    
    private weak var view: GeneralMessageViewInjection?
    private let type: GeneralMessageType
    
    // MARK - Lifecycle
    init(view: GeneralMessageViewInjection, type: GeneralMessageType) {
        self.view = view
        self.type = type
    }
    
}

extension GeneralMessagePresenter: GeneralMessagePresenterDelegate {
    
    func viewDidAppear() {
        switch type {
        case .NoInternetConnection:
            view?.load(title: "Sin conexión a la red.", message: "iMusic necesita conectarse a Internet. \n Compruebe las conexiones e intente nuevamente.")
            break
        }
    }

}
