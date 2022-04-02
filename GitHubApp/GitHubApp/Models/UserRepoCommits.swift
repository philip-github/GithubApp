//
//  UserRepoCommits.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/31/22.
//

import Foundation

class UserCommits: Codable {
    let commit: Commit?
}

class Commit: Codable {
    var message: String
    var author : Author
    var tree: Tree
}

class Author: Codable {
    var name: String
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
    }
}

class Tree: Codable {
    var sha: String
    
    enum CodingKeys: String, CodingKey{
        case sha = "sha"
    }
}
