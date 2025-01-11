//
//  TVShowsListView+Factory.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

extension TVShowsListView {
    static func make() -> TVShowsListView {
        let fetchTVShowsNetworkClient = NetworkClient()
        let searchTVShowsNetworkClient = NetworkClient()
    
        let fetchTVShowsRepository = TVShowsRepository (
            networkClient: fetchTVShowsNetworkClient
        )
    
        let fetchTVShowsUseCase = FetchTVShowsUseCase(
            repository: fetchTVShowsRepository
        )
        
        let searchTVShowsRepository = SearchTVShowsRepository(
            networkClient: searchTVShowsNetworkClient
        )
        
        let searchTVShowsUseCase = SearchTVShowsUseCase(
            repository: searchTVShowsRepository
        )
        
        let viewModel = TVShowsListViewModel(
            fetchTVShowsUseCase: fetchTVShowsUseCase,
            searchTVShowUseCase: searchTVShowsUseCase
        )
        
        return .init(viewModel: viewModel)
    }
}
