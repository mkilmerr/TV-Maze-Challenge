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
    private let personId: Int
    
    private let fetchGuestCastCreditsUseCase: FetchGuestCastCreditsUseCaseProtocol
    
    init(
        fetchGuestCastCreditUseCase: FetchGuestCastCreditsUseCaseProtocol,
        personId: Int
    ) {
        self.fetchGuestCastCreditsUseCase = fetchGuestCastCreditUseCase
        self.personId = personId
    }
    
    func loadGuestCastCredit() async {
        do {
            guestCastCredits = try await fetchGuestCastCreditsUseCase.execute(id: personId)
            print(guestCastCredits)
        } catch {
            
        }
    }
}
