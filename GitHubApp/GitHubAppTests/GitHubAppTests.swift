//
//  GitHubAppTests.swift
//  GitHubAppTests
//
//  Created by Philip Twal on 3/29/22.
//

import XCTest
@testable import GitHubApp

class GitHubAppTests: XCTestCase {
    var session: MockSession?
    var apiHandler: APIManager?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = MockSession()
        if let session = session {
            apiHandler = APIManager(session: session)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
    }

    func testAPICall() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        guard let url = URL(string: "https://api.github.com/users\(EndPoints.per_page.rawValue)\(1)") else { throw NetworkError.BadURL }
        let request = URLRequest(url: url)
//        request.addValue("token: \(Tokens.AuthToken.rawValue)", forHTTPHeaderField: "Authorization")
        if let testSession = apiHandler{
            let testTask = try await testSession.session.getData(for: request)
            let testDataFormat = try await GHViewModel.shared.getUsers(url: "https://api.github.com/users\(EndPoints.per_page.rawValue)\(1)")
            XCTAssertNotNil(testTask)
            XCTAssertEqual(testDataFormat[0].username, "mojombo", "Error")
        }
    }

    
    func testPerformanceExample() async throws {
        // This is an example of a performance test case.
        self.measure {
            
        }
    }

}
