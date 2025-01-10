//
//  PeopleDetailViewModel.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

@MainActor
final class PeopleDetailViewModel: ObservableObject {
    @Published private(set) var guestCastCredits: [GuestCastCredit] = []
    let person: Person
    
    private let fetchGuestCastCreditsUseCase: FetchGuestCastCreditsUseCaseProtocol
    
    init(
        fetchGuestCastCreditUseCase: FetchGuestCastCreditsUseCaseProtocol,
        person: Person
    ) {
        self.fetchGuestCastCreditsUseCase = fetchGuestCastCreditUseCase
        self.person = person
    }
    
    func loadGuestCastCredit() async {
        do {
            guestCastCredits = try await fetchGuestCastCreditsUseCase.execute(id: person.id)
            print(guestCastCredits)
        } catch {
            
        }
    }
}
