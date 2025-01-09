//
//  TVShowSeasonsRepositoryProtocol.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

protocol TVShowEpisodesRepositoryProtocol {
    func fetchEpisodes(by seasonId: Int) async throws -> [Episode]
}
