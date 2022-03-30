//
//  ViewModel.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/29/22.
//

import Foundation
enum NetWorkError: Error {
    case URLFromStringError
}

class ViewModel {
    
    static let shared = ViewModel()
    
    func getUser(url: String) async throws -> User {
        guard let url = URL(string: url) else { throw NetWorkError.URLFromStringError }
        do{
            let data = try await APIManager.shared.fetchUser(url: url)
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        }catch{
            throw error
        }
    }
}
