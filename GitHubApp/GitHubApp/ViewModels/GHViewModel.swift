//
//  ViewModel.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/29/22.
//

import Foundation
enum NetworkError: Error {
    case BadURL
    case DataTaskError
    case DecodeJSONError
}



class GHViewModel {
    
    static let shared = GHViewModel()
    
    func getUsers(url: String) async throws -> [User] {
        guard let url = URL(string: url) else {
            print("Error with URL [  ] GHViewModel.getUsers with URL: \(url)")
            throw NetworkError.BadURL
        }
        do{
            let data = try await APIManager.shared.getData(url: url)
            let user = try JSONDecoder().decode([User].self, from: data)
            return user
        }catch{
            print("Error [  ] GHViewModel.getUsers \(error.localizedDescription)")
            throw NetworkError.DecodeJSONError
        }
    }
    
    func getUserRepos(url: String) async throws -> [UserRepos] {
        guard let url = URL(string: url) else {
            print("Error with URL [  ] GHViewModel.getUserRepos with URL: \(url)")
            throw NetworkError.BadURL
        }
        do{
            let data = try await APIManager.shared.getData(url: url)
            let reposJson = try JSONDecoder().decode([UserRepos].self, from: data)
            return reposJson
        }catch{
            print("Error [  ] GHViewModel.getUserRepos \(error.localizedDescription)")
            throw NetworkError.DecodeJSONError
        }
    }
    
    func getRepoCommits(url: String) async throws -> [UserCommits] {
        guard let url = URL(string: url) else {
            print("Error with URL [  ] GHViewModel.getRepoCommits with URL: \(url)")
            throw NetworkError.BadURL
        }
        do{
            let data = try await APIManager.shared.getData(url: url)
            let commitsJson = try JSONDecoder().decode([UserCommits].self, from: data)
            return commitsJson
        }catch{
            print("Error [  ] GHViewModel.getRepoCommits \(error.localizedDescription)")
            throw NetworkError.DecodeJSONError
        }
    }
    
    func loadUserRepos(url: String) async throws -> [UserCommits] {
        var userRepos: [[UserRepos]] = []
        var repoCommits: [UserCommits] = []
        do{
            // get user repo commits
            let usersTask = try await getUsers(url: url)
            let reposURL = usersTask.compactMap {  return "\($0.repos)\(EndPoints.per_page.rawValue)\(1)" }
            for repo in reposURL{
                let repos = try await getUserRepos(url: repo)
                userRepos.append(repos)
            }
            let flattedArray = userRepos.joined()
            let commitsUrl = flattedArray.compactMap{ return $0.commits.replacingOccurrences(of: "{/sha}", with: "") }
            for commit in commitsUrl{
                repoCommits = try await getRepoCommits(url: commit)
            }
            return repoCommits
        }catch{
            print("Error [  ] GHViewModel.loadUserRepos \(error.localizedDescription)")
            throw error
        }
    }
}
