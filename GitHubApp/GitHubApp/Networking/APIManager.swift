//
//  APIManager.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/29/22.
//

import Foundation
class APIManager {
    
    static let shared  = APIManager()
    
    func fetchUser(url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        do{
            let (dataTask, _) = try await URLSession.shared.data(for: request)
            return dataTask
        }catch{
            throw error
        }
        
    }
}
