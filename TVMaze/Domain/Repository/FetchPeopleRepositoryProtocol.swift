//
//  FetchPeopleRepositoryProtocol.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

protocol FetchPeopleRepositoryProtocol {
    func fetchPeople(name: String) async throws-> [PersonSearched]
}
