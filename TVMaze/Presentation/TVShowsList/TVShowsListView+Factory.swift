//
//  TVShowsListView+Factory.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

extension TVShowsListView {
    static func make() -> TVShowsListView {
        let fetchTVShowsRepository = TVShowsRepository (
            networkClient: .init()
        )
    
        let fetchTVShowsUseCase = FetchTVShowsUseCase(
            repository: fetchTVShowsRepository
        )
        
        let viewModel = TVShowsListViewModel(
            fetchTVShowsUseCase: fetchTVShowsUseCase
        )
        
        return .init(viewModel: viewModel)
    }
}
