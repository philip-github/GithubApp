//
//  ErrorPresenter.swift
//  GitHubApp
//
//  Created by Philip Twal on 4/3/22.
//

import Foundation
import UIKit

class ErrorPresenter {
    
    static func showError(viewController: UIViewController)  {
        let alert = UIAlertController(title: "Error", message: "Something Went Wrong!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
