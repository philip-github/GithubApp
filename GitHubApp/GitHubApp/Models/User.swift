//
//  User.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/29/22.
//

import Foundation

struct User: Codable {
    let username: String
    let repos: String
    
    enum CodingKeys: String, CodingKey{
        case username = "login"
        case repos = "repos_url"
    }
}
