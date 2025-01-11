//
//  SearchTVShowsRepositoryProtocol.swift
//  TVMaze
//
//  Created by longarinas on 11/01/25.
//

import Foundation

protocol SearchTVShowsRepositoryProtocol {
    func fetchTVShows(by name: String) async throws -> [TVShowSearched]
}
