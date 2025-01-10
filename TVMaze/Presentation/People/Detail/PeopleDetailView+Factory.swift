//
//  PeopleDetailView+Factory.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

extension PeopleDetailView {
    static func make(with person: Person) -> PeopleDetailView {
        let fetchGuestCastCreditsRepository = FetchGuestCastCreditsRepository(
            networkClient: .init()
        )

        let fetchGuestCastCreditUseCase = FetchGuestCastCreditsUseCase(
            repository: fetchGuestCastCreditsRepository
        )

        let viewModel = PeopleDetailViewModel(
            fetchGuestCastCreditUseCase: fetchGuestCastCreditUseCase,
            person: person
        )
        
        return .init(viewModel: viewModel)
    }
}
