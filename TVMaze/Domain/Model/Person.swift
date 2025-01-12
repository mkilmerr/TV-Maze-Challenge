//
//  Person.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct PersonSearched: Decodable, Equatable {
    let score: Double
    let person: Person
}

struct Person: Decodable, Equatable {
    let id: Int
    let url: String
    let name: String
    let country: Country?
    let birthday: String?
    let deathday: String?
    let gender: String?
    let image: ImageBanner?
    let updated: Int
    let links: LinksReference
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, country, birthday, deathday, gender, image, updated
        case links = "_links"
    }
}

// MARK: Mock
extension PersonSearched {
    static func mock() -> [PersonSearched] {
        return [
            PersonSearched(
                score: 0.0, person: Person.mock()
            )
        ]
    }
}

extension Person {
    static func mock() -> Person {
        return .init(
            id: 46364,
            url: "https://www.tvmaze.com/people/46364/val-kilmer",
            name: "Val Kilmer",
            country: .init(
                name: "United States",
                code: "US",
                timezone: "America/New_York"
            ),
            birthday: "1959-12-31",
            deathday: nil,
            gender: "Male",
            image: .init(
                medium: "https://static.tvmaze.com/uploads/images/medium_portrait/145/364355.jpg",
                original: "https://static.tvmaze.com/uploads/images/original_untouched/145/364355.jpg"
            ),
            updated: 1702612344,
            links: .init(
                linksSelf: .init(
                    href: "https://api.tvmaze.com/people/46364",
                    name: nil
                ),
                previousEpisode: nil
            )
        )
    }
}
