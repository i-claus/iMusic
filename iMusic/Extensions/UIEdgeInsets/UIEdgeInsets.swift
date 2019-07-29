//
//  UIEdgeInsets.swift
//  iMusic
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import Foundation

extension UIEdgeInsets {
    
    static var safeAreaInsets: UIEdgeInsets = {
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return UIEdgeInsets.zero }
        let insets: UIEdgeInsets
        if #available(iOS 11.0, *) {
            insets = window.safeAreaInsets
        } else {
            insets = UIEdgeInsets.zero
        }
        return insets
    }()
    
}
