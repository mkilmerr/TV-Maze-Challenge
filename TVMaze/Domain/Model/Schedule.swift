//
//  Schedule.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

struct Schedule: Decodable, Equatable {
    let time: String
    let days: [String]
}
