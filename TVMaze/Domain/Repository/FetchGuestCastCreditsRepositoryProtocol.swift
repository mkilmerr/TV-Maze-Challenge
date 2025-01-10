//
//  FetchGuestCastCreditRepositoryProtocol.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

protocol FetchGuestCastCreditsRepositoryProtocol {
    func fetchGuestCastCredit(with id: Int) async throws-> [GuestCastCredit]
}
