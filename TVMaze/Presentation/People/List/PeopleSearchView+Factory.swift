//
//  PeopleListView+Factory.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

extension PeopleSearchView {
    static func make() -> PeopleSearchView {
        let fetchPeopleRepository = FetchPeopleRepository(
            networkClient: .init()
        )
        
        let fetchPeopleUseCase = FetchPeopleUseCase(
            repository: fetchPeopleRepository
        )
        
        let viewModel = PeopleSearchViewModel(
            fetchPeopleUseCase: fetchPeopleUseCase
        )
        
        return .init(viewModel: viewModel)
    }
}
