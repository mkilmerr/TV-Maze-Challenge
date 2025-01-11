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
    
    func fetchPeople(name: String) async throws-> [PersonSearched] {
        let endpoint = PeopleEndpoint(name: name)
        let people: [PersonSearched] = try await networkClient.request(endpoint)
        return people
    }
}
