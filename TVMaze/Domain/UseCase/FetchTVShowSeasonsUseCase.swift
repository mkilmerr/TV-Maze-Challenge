//
//  FetchTVShowSeasonsUseCase.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

protocol FetchTVShowEpisodesUseCaseProtocol {
    func execute(id: Int) async throws -> [Episode]
}

final class FetchTVShowEpisodesUseCase: FetchTVShowEpisodesUseCaseProtocol {
    let repository: TVShowEpisodesRepositoryProtocol

    init(repository: TVShowEpisodesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int) async throws -> [Episode] {
        try await repository.fetchEpisodes(by: id)
    }
}
