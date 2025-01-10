//
//  PeopleListViewModel.swift
//  TVMaze
//
//  Created by longarinas on 10/01/25.
//

import Foundation

@MainActor
final class PeopleListViewModel: ObservableObject {
    @Published var personSelected: Person?
    @Published private(set) var people: [Person] = []
    @Published private(set) var isLoading = false
    
    private var currentPage = 0
    private let fetchPeopleUseCase: FetchPeopleUseCaseProtocol
    
    init(fetchPeopleUseCase: FetchPeopleUseCaseProtocol) {
        self.fetchPeopleUseCase = fetchPeopleUseCase
    }
    
    func loadPeople() async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let newPeople = try await fetchPeopleUseCase.execute(page: currentPage)
            people.append(contentsOf: newPeople)
            currentPage += 1
        } catch {
            print("Error loading people: \(error)")
        }
    }
}

