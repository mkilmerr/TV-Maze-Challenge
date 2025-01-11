//
//  PeopleListViewModel.swift
//  TVMaze
//
//  Created by longarinas on 10/01/25.
//

import Foundation

@MainActor
final class PeopleSearchViewModel: ObservableObject {
    @Published var personSelected: Person?
    @Published var people: [PersonSearched] = []
    @Published private(set) var isLoading = false
    
    private let fetchPeopleUseCase: FetchPeopleUseCaseProtocol
    
    init(fetchPeopleUseCase: FetchPeopleUseCaseProtocol) {
        self.fetchPeopleUseCase = fetchPeopleUseCase
    }
    
    func loadPeople(by name: String) async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            people = try await fetchPeopleUseCase.execute(name: name)
        } catch {
            people.removeAll()
            print("Error loading people: \(error)")
        }
    }
    
    func search(by name: String) async {
        if name.isEmpty {
            people.removeAll()
        } else {
            await loadPeople(by: name)
        }
    }
}

