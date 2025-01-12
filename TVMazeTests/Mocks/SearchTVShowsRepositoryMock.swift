//
//  SearchTVShowsRepositoryMock.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import Foundation
@testable import TVMaze

final class SearchTVShowsRepositoryMock: SearchTVShowsRepositoryProtocol {
    var result: [TVShowSearched]?
    var error: Error?
    var searchName: String?

    func fetchTVShows(by name: String) async throws -> [TVShowSearched] {
        self.searchName = name
        
        if let error = error {
            throw error
        }

        return result ?? []
    }
}
