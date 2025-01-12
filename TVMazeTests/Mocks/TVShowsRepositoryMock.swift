//
//  TVShowsRepositoryMock.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import Foundation
@testable import TVMaze

final class TVShowsRepositoryMock: TVShowsRepositoryProtocol {
    var result: [TVShow]?
    var error: Error?
    var page: Int?
    
    func fetchShows(page: Int) async throws -> [TVShow] {
        self.page = page
        
        if let error = error {
            throw error
        }
        
        return result ?? []
    }
}
