//
//  Links.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

struct Links: Decodable {
    let linksSelf: Link
    let previousEpisode: Link?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousEpisode = "previousepisode"
    }
}
