//
//  UserRepos.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/31/22.
//

import Foundation


class UserRepos: Codable {
    let name: String
    let commits: String
    var owner: Owner?
    
    enum CodingKeys: String, CodingKey{
        case commits = "commits_url"
        case name = "name"
        case owner
    }
}

class Owner: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey{
        case name = "login"
    }
}
