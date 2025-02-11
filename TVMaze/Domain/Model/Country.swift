//
//  Country.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

struct Country: Decodable, Equatable {
    let name: String
    let code: String
    let timezone: String
}
