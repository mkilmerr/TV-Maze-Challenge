//
//  FetchGuestCastCreditUseCase.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

protocol FetchGuestCastCreditsUseCaseProtocol {
    func execute(id: Int) async throws -> [GuestCastCredit]
}

final class FetchGuestCastCreditsUseCase: FetchGuestCastCreditsUseCaseProtocol {
    let repository: FetchGuestCastCreditsRepositoryProtocol

    init(repository: FetchGuestCastCreditsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int) async throws -> [GuestCastCredit] {
       try await repository.fetchGuestCastCredit(with: id)
    }
}
