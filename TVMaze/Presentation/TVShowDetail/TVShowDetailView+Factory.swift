//
//  TVShowDetailView+Factory.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation
import SwiftData

extension TVShowDetailView {
    static func make(with show: TVShow, modelContext: ModelContext) -> TVShowDetailView {
        let fetchShowEpisodesRepository = TVShowEpisodesRepository(
            networkClient: .init()
        )

        let fetchTVShowEpisodesUseCase = FetchTVShowEpisodesUseCase(
            repository: fetchShowEpisodesRepository
        )

        let viewModel = TVShowDetailViewModel(
            fetchEpisodesUseCase: fetchTVShowEpisodesUseCase,
            show: show,
            modelContext: modelContext
        )

        return .init(viewModel: viewModel)
    }
}
