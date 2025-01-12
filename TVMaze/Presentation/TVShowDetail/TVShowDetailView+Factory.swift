//
//  TVShowDetailView+Factory.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation
import SwiftData

extension TVShowDetailView {
    static func make(with show: TVShow) -> TVShowDetailView {
        let fetchShowEpisodesRepository = TVShowEpisodesRepository(
            networkClient: NetworkClient()
        )

        let fetchTVShowEpisodesUseCase = FetchTVShowEpisodesUseCase(
            repository: fetchShowEpisodesRepository
        )

        let viewModel = TVShowDetailViewModel(
            fetchEpisodesUseCase: fetchTVShowEpisodesUseCase,
            show: show
        )

        return .init(viewModel: viewModel)
    }
}
