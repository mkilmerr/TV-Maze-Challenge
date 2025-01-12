//
//  FetchPeopleUseCase.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

//MARK: UseCase
protocol FetchPeopleUseCaseProtocol {
    func execute(name: String) async throws -> [PersonSearched]
}

final class FetchPeopleUseCase: FetchPeopleUseCaseProtocol {
    let repository: FetchPeopleRepositoryProtocol
    
    init(repository: FetchPeopleRepositoryProtocol) {
        self.repository = repository
    }

    func execute(name: String) async throws -> [PersonSearched] {
        try await repository.fetchPeople(name: name)
    }
}

// MARK: Mock
final class FetchPeopleUseCaseMock: FetchPeopleUseCaseProtocol {
    func execute(name: String) async throws -> [PersonSearched] {
        return PersonSearched.mock()
    }
}
