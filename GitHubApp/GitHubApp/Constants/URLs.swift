//  GitHubURLs.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/29/22.
//

import Foundation

enum NetworkURL: String {
    case Users = "https://api.github.com/users"
}

enum EndPoints: String {
    case per_page = "?per_page="
    case page = "?page="
}
