//
//  Loader.swift
//  GitHubApp
//
//  Created by Philip Twal on 4/3/22.
//

import Foundation
import UIKit


class Loader {
    
    static let shared = Loader()
    
    var loaderIndicator: UIActivityIndicatorView?
    var alert: UIAlertController?
    
    func showLoading(viewController: UIViewController) {
        alert = UIAlertController(title: nil, message: "Please Wait", preferredStyle: .alert)
        loaderIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        alert?.view.addSubview(loaderIndicator!)
        loaderIndicator?.startAnimating()
        viewController.present(alert!, animated: true, completion: nil)
    }
    
    func stopLoading(){
        loaderIndicator?.stopAnimating()
        alert?.dismiss(animated: true, completion: nil)
    }
}
