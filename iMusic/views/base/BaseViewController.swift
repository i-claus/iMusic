//
//  BaseViewController.swift
//  iMusic
//
//  Created by Claudio Vega on 27/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // Show the loader
    
    public func showLoader(_ show: Bool, status: String? = nil) {
        if let status = status {
            show == true ? SVProgressHUD.show(withStatus: status) : SVProgressHUD.dismiss()
            return
        }
        show == true ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }
    
    //Show alert
 
    public func showAlertWith(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(
            title: actionTitle,
            style: .default,
            handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
}

