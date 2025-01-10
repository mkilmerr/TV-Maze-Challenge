//
//  TVShowDetailView+Factory.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

extension TVShowDetailView {
    static func make(with show: TVShow) -> TVShowDetailView {
        let fetchShowEpisodesRepository = TVShowEpisodesRepository(
            networkClient: .init()
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
