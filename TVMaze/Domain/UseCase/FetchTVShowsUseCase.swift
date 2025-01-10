//
//  FetchTVShowsUseCase.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

// MARK: Use Case
protocol FetchTVShowsUseCaseProtocol {
    func execute(page: Int) async throws -> [TVShow]
}

final class FetchTVShowsUseCase: FetchTVShowsUseCaseProtocol {
    private let repository: TVShowsRepositoryProtocol
    
    init(repository: TVShowsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> [TVShow] {
        try await repository.fetchShows(page: page)
    }
}

// MARK: - Mock
final class FetchTVShowsUseCaseMock: FetchTVShowsUseCaseProtocol {
    func execute(page: Int) async throws -> [TVShow] {
        TVShow.mockShows()
    }
}
