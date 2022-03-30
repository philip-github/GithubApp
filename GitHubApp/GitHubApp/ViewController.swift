//
//  ViewController.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/29/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
    }
    
    func getUser() {
        Task.init(priority: .background) {
            let user = try await ViewModel.shared.getUser(url: NetworkURL.UserURL.rawValue)
            print(user.username)
        }
    }
}

