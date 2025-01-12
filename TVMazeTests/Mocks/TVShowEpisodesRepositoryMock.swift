//
//  TVShowEpisodesRepositoryMock.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import Foundation
@testable import TVMaze

final class TVShowEpisodesRepositoryMock: TVShowEpisodesRepositoryProtocol {
    var result: [Episode]?
    var error: Error?
    var seasonId: Int?
    
    func fetchEpisodes(by seasonId: Int) async throws -> [Episode] {
        self.seasonId = seasonId
        
        if let error = error {
            throw error
        }
        
        return result ?? []
    }
}
