//
//  FetchPeopleUseCaseMock.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import Foundation
@testable import TVMaze

final class FetchPeopleUseCaseMock: FetchPeopleUseCaseProtocol {
    var result: [PersonSearched]?
    var error: Error?
    private(set) var executeCallCount = 0
    
    func execute(name: String) async throws -> [PersonSearched] {
        executeCallCount += 1
        
        if let error = error {
            throw error
        }
        
        return result ?? []
    }
}
