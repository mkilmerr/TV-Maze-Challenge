//
//  LinksReference.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

struct LinksReference: Decodable, Equatable {
    let linksSelf: LinkReference
    let previousEpisode: LinkReference?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousEpisode = "previousepisode"
    }
}
