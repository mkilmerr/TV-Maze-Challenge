//
//  Episode.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct Episode: Decodable {
    let id: Int
    let url: String
    let name: String
    let season: Int
    let number: Int
    let type: String
    let airdate: String
    let airtime: String
    let airstamp: String
    let runtime: Int
    let rating: Rating
    let image: ShowImage?
    let summary: String?
    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary
        case links = "_links"
    }
}

struct SelfLink: Decodable {
    let href: String
}

struct Show: Decodable {
    let href: String
    let name: String
}
