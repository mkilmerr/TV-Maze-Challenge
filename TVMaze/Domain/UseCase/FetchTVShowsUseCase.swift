//
//  FetchTVShowsUseCase.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

protocol FetchTVShowsUseCaseProtocol {
    func execute(page: Int) async throws -> [TVShow]
}

final class FetchTVShowsUseCase: FetchTVShowsUseCaseProtocol {
    private let repository: TVShowsRepositoryProtocol
    
    init(repository: TVShowsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> [TVShow] {
        return try await repository.fetchShows(page: page)
    }
}
