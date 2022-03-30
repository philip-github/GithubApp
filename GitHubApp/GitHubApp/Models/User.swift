//
//  User.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/29/22.
//

import Foundation

struct User: Codable {
    var username: String
    
    enum CodingKeys: String, CodingKey{
        case username = "login"
    }
}


struct UserRepos: Codable {
    var repoUrl: String
    
    enum CodingKeys: String, CodingKey{
        case repoUrl = "archive_url"
    }
}
