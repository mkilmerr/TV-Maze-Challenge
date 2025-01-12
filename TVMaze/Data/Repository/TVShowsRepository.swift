//
//  TVShowsRepository.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

final class TVShowsRepository: TVShowsRepositoryProtocol {
    private let networkClient: HTTPClient

    init(networkClient: HTTPClient) {
        self.networkClient = networkClient
    }

    func fetchShows(page: Int) async throws -> [TVShow] {
        let endpoint = TVShowsEndpoint(page: page)
        let shows: [TVShow] = try await networkClient.request(endpoint)
        return shows
    }
}
