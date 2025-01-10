//
//  FetchGuestCastCreditRepository.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

final class FetchGuestCastCreditsRepository: FetchGuestCastCreditsRepositoryProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchGuestCastCredit(with id: Int) async throws -> [GuestCastCredit] {
        let endpoint = GuestCastCreditEndpoint(id: id)
        let guestCastCredit: [GuestCastCredit] = try await networkClient.request(
            endpoint
        )
        return guestCastCredit
    }
}
