//
//  PeopleListView+Factory.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

extension PeopleListView {
    static func make() -> PeopleListView {
        let fetchPeopleRepository = FetchPeopleRepository(
            networkClient: .init()
        )
        
        let fetchPeopleUseCase = FetchPeopleUseCase(
            repository: fetchPeopleRepository
        )
        
        let viewModel = PeopleListViewModel(
            fetchPeopleUseCase: fetchPeopleUseCase
        )
        
        return .init(viewModel: viewModel)
    }
}
