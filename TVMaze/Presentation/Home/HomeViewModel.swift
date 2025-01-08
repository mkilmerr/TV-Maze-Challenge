//
//  HomeViewModel.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var tvShows: [TVShow] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isError: Bool = false
    private var currentPage = 0
    private let fetchTVShowsUseCase: FetchTVShowsUseCaseProtocol

    init(fetchTVShowsUseCase: FetchTVShowsUseCaseProtocol) {
        self.fetchTVShowsUseCase = fetchTVShowsUseCase
    }

    func loadTVShows() async {
        isLoading = true

        do {
            currentPage += 1
            let shows = try await fetchTVShowsUseCase.execute(page: currentPage)
            tvShows.append(contentsOf: shows)
            isLoading = false
        } catch {
            isLoading = false
            isError = true
        }
    }
}
