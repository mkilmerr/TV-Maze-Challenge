//
//  FetchPeopleRepository.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

final class FetchPeopleRepository: FetchPeopleRepositoryProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchPeople(page: Int) async throws-> [Person] {
        let endpoint = PeopleEndpoint(page: page)
        let people: [Person] = try await networkClient.request(endpoint)
        return people
    }
}
