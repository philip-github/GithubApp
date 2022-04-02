//  GitHubURLs.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/29/22.
//

import Foundation

enum NetworkURL: String {
    case Users = "https://api.github.com/users"
//    case UserURL = "https://api.github.com/users/philip-github"
//    case UserRepos = "https://api.github.com/users/philip-github/repos"
//    case repoCommits = "https://api.github.com/repos/philip-github/GithubApp/commits/master?per_page=30"
}

enum EndPoints: String {
    case per_page = "?per_page="
    case page = "?page="
}
