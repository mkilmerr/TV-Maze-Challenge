//
//  FetchPeopleRepositoryMock.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import Foundation
@testable import TVMaze

final class FetchPeopleRepositoryMock: FetchPeopleRepositoryProtocol {
    var result: [PersonSearched]?
    var error: Error?
    var searchName: String?
    
    func fetchPeople(name: String) async throws -> [PersonSearched] {
        self.searchName = name
        
        if let error = error {
            throw error
        }
        
        return result ?? []
    }
}
