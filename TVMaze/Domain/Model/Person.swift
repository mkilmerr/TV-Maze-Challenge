//
//  Person.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct PersonSearched: Decodable {
    let score: Double
    let person: Person
}

struct Person: Decodable {
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
