//
//  UserRepoCommits.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/31/22.
//

import Foundation

struct UserCommits: Codable {
    let commit: Commit?
}

struct Commit: Codable {
    var message: String
    var author : Author
    var tree: Tree
}

struct Author: Codable {
    var name: String
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
    }
}

struct Tree: Codable {
    var sha: String
    
    enum CodingKeys: String, CodingKey{
        case sha = "sha"
    }
}
