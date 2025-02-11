//
//  SearchTVShowsUseCase.swift
//  TVMaze
//
//  Created by longarinas on 11/01/25.
//

import Foundation

// MARK: UseCase
protocol SearchTVShowsUseCaseProtocol {
    func execute(name: String) async throws -> [TVShowSearched]
}

final class SearchTVShowsUseCase: SearchTVShowsUseCaseProtocol {
    let repository: SearchTVShowsRepositoryProtocol

    init(repository: SearchTVShowsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(name: String) async throws -> [TVShowSearched] {
        return try await repository.fetchTVShows(by: name)
    }
}

// MARK: Mock
final class SearchTVShowsUseCaseMock: SearchTVShowsUseCaseProtocol {
    var called: Bool = false
    func execute(name: String) async throws -> [TVShowSearched] {
        called.toggle()
        return [TVShowSearched.mock()]
    }
}
