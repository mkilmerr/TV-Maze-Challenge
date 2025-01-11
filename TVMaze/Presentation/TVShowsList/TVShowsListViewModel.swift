//
//  TVShowsListViewModel.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI

@MainActor
final class TVShowsListViewModel: ObservableObject {
    @Published private(set) var tvShows: [TVShow] = []
    @Published private(set) var tvShowsFromSearch: [TVShowSearched] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isError: Bool = false
    @Published var searchText: String = ""
    private var currentPage = 0
    
    private let fetchTVShowsUseCase: FetchTVShowsUseCaseProtocol
    private let searchTVShowUseCase: SearchTVShowsUseCaseProtocol
    
    init(
        fetchTVShowsUseCase: FetchTVShowsUseCaseProtocol,
        searchTVShowUseCase: SearchTVShowsUseCaseProtocol
    ) {
        self.fetchTVShowsUseCase = fetchTVShowsUseCase
        self.searchTVShowUseCase = searchTVShowUseCase
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
    
    var tvShowsToPresent: [TVShow] {
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
