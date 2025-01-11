//
//  TVShowsListViewModel.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI
import SwiftData

@MainActor
final class TVShowsListViewModel: ObservableObject {
    @Published private(set) var tvShows: [TVShow] = []
    @Published private(set) var tvShowsFromSearch: [TVShowSearched] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isError: Bool = false
    @Published var searchText: String = ""
    private var currentPage = 0
    
    var isFromFavorite: Bool = false
    private let modelContext: ModelContext
    private let fetchTVShowsUseCase: FetchTVShowsUseCaseProtocol
    private let searchTVShowUseCase: SearchTVShowsUseCaseProtocol
    let mode: TVShowsListView.Mode
    
    init(
        fetchTVShowsUseCase: FetchTVShowsUseCaseProtocol,
        searchTVShowUseCase: SearchTVShowsUseCaseProtocol,
        modelContext: ModelContext,
        mode: TVShowsListView.Mode
    ) {
        self.fetchTVShowsUseCase = fetchTVShowsUseCase
        self.searchTVShowUseCase = searchTVShowUseCase
        self.mode = mode
        self.modelContext = modelContext
    }

    private var matchingTVShows: [TVShow] {
        if searchText.isEmpty {
            return tvShows
        } else {
            return tvShows.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    private func getUniqueTVShows(_ shows: [TVShow]) -> [TVShow] {
        var uniqueTVShows = Set<Int>()
        return shows.filter { show in
            guard !uniqueTVShows.contains(show.id) else { return false }
            uniqueTVShows.insert(show.id)
            return true
        }
    }
    
    var title: String {
        switch mode {
        case .defaultList:
            "TV Shows"
        case .favorite:
            "Favorite TV Shows"
        }
    }
    
    var searchPlaceholder: String {
        switch mode {
        case .defaultList:
            "Search TV Show..."
        case .favorite:
            "Search my favorites"
        }
    }
    
    func getTVShowsToPresent(_ local: [TVShowLocalData]) -> [TVShow] {
        switch mode {
        case .defaultList:
            return tvShowsFromRemote
        case .favorite:
            let localTVShows = local.map { $0.toTVShow() }
            return getUniqueTVShows(localTVShows)
        }
    }

    private var tvShowsFromRemote: [TVShow] {
        if searchText.isEmpty {
            return matchingTVShows
        } else {
            return getUniqueTVShows(tvShowsFromSearch.map { $0.show })
        }
    }
    
    var showFetchingMoreText: Bool {
        !tvShows.isEmpty && searchText.isEmpty
    }

    func loadTVShows() async {
        isLoading = true
        do {
            currentPage += 1
            let shows = try await fetchTVShowsUseCase.execute(page: currentPage)
            tvShows.append(contentsOf: getUniqueTVShows(shows))
            isLoading = false
        } catch {
            isLoading = false
            isError = true
        }
    }
    
    func loadTVShows(by name: String) async {
        isLoading = true
        do {
            tvShowsFromSearch.removeAll()
            let shows = try await searchTVShowUseCase.execute(name: name)
            tvShowsFromSearch.append(contentsOf: shows)
            isLoading = false
        } catch {
            isLoading = false
            isError = true
        }
    }
}
