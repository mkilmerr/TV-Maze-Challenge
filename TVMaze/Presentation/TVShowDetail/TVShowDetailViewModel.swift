//
//  TVShowDetailViewModel.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation
import SwiftData

struct EpisodeItemViewModel: Identifiable {
    let id = UUID()
    let seasonNumber: Int
    let episodes: [Episode]
}

@MainActor
final class TVShowDetailViewModel: ObservableObject {
    let show: TVShowRepresentable
    @Published private(set) var episodes: [EpisodeItemViewModel] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let modelContext: ModelContext
    let fetchEpisodesUseCase: FetchTVShowEpisodesUseCaseProtocol
    lazy var localDataManager = LocalDataManager<TVShowLocalData>(context: modelContext)
    
    init(
        fetchEpisodesUseCase: FetchTVShowEpisodesUseCaseProtocol,
        show: TVShow,
        modelContext: ModelContext
    ) {
        self.fetchEpisodesUseCase = fetchEpisodesUseCase
        self.show = show
        self.modelContext = modelContext
    }

    func loadSeasons() async {
        isLoading = true
        do {
            let episodesResponse = try await fetchEpisodesUseCase.execute(id: show.id)
            episodes = getGroupedEpisodesBySeason(episodes: episodesResponse)
            isLoading = false
        } catch {
            self.error = error
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
    
    func favoriteTVShow() async {
        if let show = show as? TVShow {
            let localData = show.toLocalData()
            localDataManager.save(localData)
        }
    }
}
