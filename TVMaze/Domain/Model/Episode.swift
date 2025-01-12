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
    let image: ImageBanner?
    let summary: String?
    let links: LinksReference
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary
        case links = "_links"
    }
}

extension Episode {
    static func mock() -> Episode {
        return .init(
            id: 61087,
            url: "https://www.tvmaze.com/episodes/61087/everybody-hates-chris-1x01-everybody-hates-the-pilot",
            name: "Everybody Hates the Pilot",
            season: 1,
            number: 1,
            type: "regular",
            airdate: "2005-09-22",
            airtime: "12:00",
            airstamp: "2005-09-22T16:00:00+00:00",
            runtime: 30,
            rating: .init(average: 8.0),
            image: .init(
                medium: "https://static.tvmaze.com/uploads/images/medium_landscape/308/770904.jpg",
                original: "https://static.tvmaze.com/uploads/images/original_untouched/308/770904.jpg"
            ),
            summary: "Lore ipsum Lore ipsum Lore ipsum Lore ipsum",
            links: .init(
                linksSelf: .init(
                    href: "https://api.tvmaze.com/episodes/61087",
                    name: nil),
                previousEpisode: nil
            )
        )
    }
}
