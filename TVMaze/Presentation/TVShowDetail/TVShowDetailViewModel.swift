//
//  TVShowDetailViewModel.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation
import SwiftData

final class TVShowDetailViewModel: ObservableObject {
    let show: TVShowRepresentable
    @Published private(set) var episodes: [EpisodeItemViewModel] = []
    @Published private(set) var isLoading = false
    @Published var isError: Bool = false

    let fetchEpisodesUseCase: FetchTVShowEpisodesUseCaseProtocol
    
    init(
        fetchEpisodesUseCase: FetchTVShowEpisodesUseCaseProtocol,
        show: TVShow
    ) {
        self.fetchEpisodesUseCase = fetchEpisodesUseCase
        self.show = show
    }
    
    @MainActor
    func loadEpisodes() async {
        isLoading = true
        do {
            let episodesResponse = try await fetchEpisodesUseCase.execute(id: show.id)
            episodes = getGroupedEpisodesBySeason(episodes: episodesResponse)
            isLoading = false
        } catch {
            isError = true
            isLoading = false
        }
    }
    
    private func getGroupedEpisodesBySeason(episodes: [Episode]) -> [EpisodeItemViewModel] {
        let episodesGrouped = Dictionary(grouping: episodes, by: { $0.season })
        
        return episodesGrouped.map { season, episodes in
            EpisodeItemViewModel(
                seasonNumber: season,
                episodes: episodes.sorted(by: { $0.number < $1.number })
            )
        }
        .sorted(by: { $0.seasonNumber < $1.seasonNumber })
    }
}
