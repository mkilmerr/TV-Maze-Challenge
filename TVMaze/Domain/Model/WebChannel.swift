//
//  WebChannel.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

struct WebChannel: Decodable, Equatable {
    let id: Int
    let name: String
    let country: Country?
    let officialSite: String?
}
