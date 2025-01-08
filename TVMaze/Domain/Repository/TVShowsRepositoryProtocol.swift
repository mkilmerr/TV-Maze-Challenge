//
//  TVShowsRepositoryProtocol.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

protocol TVShowsRepositoryProtocol {
    func fetchShows(page: Int) async throws -> [TVShow]
}
