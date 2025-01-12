//
//  SearchTVShowsRepository.swift
//  TVMaze
//
//  Created by longarinas on 11/01/25.
//

import Foundation

final class SearchTVShowsRepository: SearchTVShowsRepositoryProtocol {
    let networkClient: HTTPClient

    init(networkClient: HTTPClient) {
        self.networkClient = networkClient
    }

    func fetchTVShows(by name: String) async throws -> [TVShowSearched] {
        let endpoint = SearchTVShowsEndpoint(name: name)
        let tvShows: [TVShowSearched] = try await networkClient.request(endpoint)
        return tvShows
    }
}
