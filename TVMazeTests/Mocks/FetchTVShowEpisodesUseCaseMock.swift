//
//  FetchTVShowEpisodesUseCaseMock.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import Foundation
@testable import TVMaze

final class FetchTVShowEpisodesUseCaseMock: FetchTVShowEpisodesUseCaseProtocol {
    var result: [Episode]?
    var error: Error?
    
    func execute(id: Int) async throws -> [Episode] {
        if let error = error {
            throw error
        }
        
        return result ?? []
    }
}
