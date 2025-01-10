//
//  TVShowSeason.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct TVShowSeason: Decodable {
    let id: Int
    let url: String
    let number: Int
    let name: String
    let episodeOrder: Int
    let premiereDate: String?
    let endDate: String?
    let network: Network?
    let webChannel: WebChannel?
    let image: ImageBanner?
    let summary: String?
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, number, name, episodeOrder, premiereDate, endDate, network, webChannel, image, summary
        case links = "_links"
    }
}
