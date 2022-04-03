//
//  MockSession.swift
//  GitHubAppTests
//
//  Created by Philip Twal on 4/2/22.
//

import Foundation
@testable import GitHubApp


class MockSession : URLSessionProtocol {
    
    
    func getData(for urlrequest: URLRequest) async throws -> Data {
        
        let json = """
[
        {
        "avatar_url" = "https://avatars.githubusercontent.com/u/1?v=4";
        "events_url" = "https://api.github.com/users/mojombo/events{/privacy}";
        "followers_url" = "https://api.github.com/users/mojombo/followers";
        "following_url" = "https://api.github.com/users/mojombo/following{/other_user}";
        "gists_url" = "https://api.github.com/users/mojombo/gists{/gist_id}";
        "gravatar_id" = "";
        "html_url" = "https://github.com/mojombo";
        id = 1;
        login = mojombo;
        "node_id" = "MDQ6VXNlcjE=";
        "organizations_url" = "https://api.github.com/users/mojombo/orgs";
        "received_events_url" = "https://api.github.com/users/mojombo/received_events";
        "repos_url" = "https://api.github.com/users/mojombo/repos";
        "site_admin" = 0;
        "starred_url" = "https://api.github.com/users/mojombo/starred{/owner}{/repo}";
        "subscriptions_url" = "https://api.github.com/users/mojombo/subscriptions";
        type = User;
        url = "https://api.github.com/users/mojombo";
    }
]


"""
        guard let jsonData = json.data(using: .utf8) else {
            print("Error [  ] User data task unit test failed")
            throw NetworkError.DataTaskError
        }
        return jsonData
    }
}
