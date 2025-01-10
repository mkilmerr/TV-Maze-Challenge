//
//  Person.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct Person: Decodable {
    let id: Int
    let url: String
    let name: String
    let country: Country?
    let birthday, deathday: String?
    let gender: Gender?
    let image: ImageBanner?
    let updated: Int
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, name, country, birthday, deathday, gender, image, updated
        case links = "_links"
    }
}
