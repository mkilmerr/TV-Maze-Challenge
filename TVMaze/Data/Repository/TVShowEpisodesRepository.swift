//
//  TVShowSeasonsRepository.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

final class TVShowEpisodesRepository: TVShowEpisodesRepositoryProtocol {
    private let networkClient: HTTPClient

    init(networkClient: HTTPClient) {
        self.networkClient = networkClient
    }
    
    func fetchEpisodes(by seasonId: Int) async throws -> [Episode] {
        let endpoint = TVShowEpisodesEndpoint(id: seasonId)
        let episodes: [Episode] = try await networkClient.request(endpoint)
        return episodes
    }
}
