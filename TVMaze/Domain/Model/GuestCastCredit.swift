//
//  GuestCastCredit.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct GuestCastCredit: Decodable {
    let creditSelf, voice: Bool
    let links: GuestCastCreditLinks

    enum CodingKeys: String, CodingKey {
        case creditSelf = "self"
        case voice
        case links = "_links"
    }
}

struct GuestCastCreditLinks: Decodable {
    let episode, character: CreditRef
}
