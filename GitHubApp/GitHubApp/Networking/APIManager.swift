//
//  APIManager.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/29/22.
//
import Foundation

protocol URLSessionProtocol {
    func getData(for urlrequest: URLRequest) async throws -> Data
}

extension URLSession: URLSessionProtocol {
    func getData(for urlrequest: URLRequest) async throws -> Data {
        let (task, _) = try await URLSession.shared.data(for: urlrequest)
        return task
    }
}

class APIManager {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
   
    func getData(url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.addValue("token: \(Tokens.AuthToken.rawValue)", forHTTPHeaderField: "Authorization")
        do{
            let dataTask = try await session.getData(for: request)
            return dataTask
        }catch{
            print("Error [      ] APIManager.getData \(error.localizedDescription)")
            throw NetworkError.DataTaskError
        }
    }
}
