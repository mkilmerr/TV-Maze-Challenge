//
//  FetchPeopleUseCase.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

protocol FetchPeopleUseCaseProtocol {
    func execute(page: Int) async throws -> [Person]
}

final class FetchPeopleUseCase: FetchPeopleUseCaseProtocol {
    let repository: FetchPeopleRepositoryProtocol
    
    init(repository: FetchPeopleRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> [Person] {
        try await repository.fetchPeople(page: page)
    }
}
