//
//  TVMazeApp.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI

@main
struct TVMazeApp: App {
    var body: some Scene {
        WindowGroup {
            TVShowsListView(viewModel: .init(fetchTVShowsUseCase: FetchTVShowsUseCase(repository: TVShowsRepository(networkClient: .init()))))
        }
    }
}
