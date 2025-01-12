//
//  TVShow.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

struct TVShowSearched: Decodable, Equatable {
    let score: Double
    let show: TVShow
}

struct TVShow: Decodable, Identifiable, Equatable, TVShowRepresentable {
    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let status: String
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network: Network?
    let webChannel: WebChannel?
    let dvdCountry: String?
    let externals: Externals
    let image: ImageBanner?
    let summary: String?
    let updated: Int
    let links: LinksReference

    var remoteImage: String? {
        image?.original
    }

    var average: Double? {
        rating.average
    }

    var scheduleDays: [String]? {
        schedule.days
    }

    var time: String {
        schedule.time
    }

    func toLocalData() -> TVShowLocalData {
        return TVShowLocalData(from: self)
    }

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status
        case runtime, averageRuntime, premiered, ended
        case officialSite, schedule, rating, weight
        case network, webChannel, dvdCountry, externals
        case image, summary, updated
        case links = "_links"
    }
}


// MARK: Mock
extension TVShow {
    static func mockShows() -> [TVShow] {
        return [
            TVShow(
                id: 1,
                url: "https://example.com/show1",
                name: "Breaking Bad",
                type: "Scripted",
                language: "English",
                genres: ["Drama", "Crime", "Thriller"],
                status: "Ended",
                runtime: 60,
                averageRuntime: 60,
                premiered: "2008-01-20",
                ended: "2013-09-29",
                officialSite: "https://www.amc.com/shows/breaking-bad",
                schedule: Schedule(time: "21:00", days: ["Sunday"]),
                rating: Rating(average: 9.5),
                weight: 99,
                network: Network(id: 20, name: "AMC", country: Country(name: "United States", code: "US", timezone: "America/New_York"), officialSite: nil),
                webChannel: nil,
                dvdCountry: nil,
                externals: Externals(tvrage: 18164, thetvdb: 81189, imdb: "tt0903747"),
                image: ImageBanner(medium: "https://example.com/medium1.jpg", original: "https://example.com/original1.jpg"),
                summary: "A high school chemistry teacher turned methamphetamine manufacturer partners with a former student to secure his family's financial future as he battles terminal lung cancer.",
                updated: 1631234567,
                links: LinksReference(linksSelf: LinkReference(href: "https://api.tvmaze.com/shows/1", name: nil), previousEpisode: LinkReference(href: "https://api.tvmaze.com/episodes/1", name: nil))
            ),
            TVShow(
                id: 2,
                url: "https://example.com/show2",
                name: "Better Call Saul",
                type: "Scripted",
                language: "English",
                genres: ["Drama", "Crime"],
                status: "Ended",
                runtime: 60,
                averageRuntime: 60,
                premiered: "2015-02-08",
                ended: "2022-08-15",
                officialSite: "https://www.amc.com/shows/better-call-saul",
                schedule: Schedule(time: "21:00", days: ["Monday"]),
                rating: Rating(average: 9.3),
                weight: 98,
                network: Network(id: 20, name: "AMC", country: Country(name: "United States", code: "US", timezone: "America/New_York"), officialSite: nil),
                webChannel: nil,
                dvdCountry: nil,
                externals: Externals(tvrage: 37780, thetvdb: 273181, imdb: "tt3032476"),
                image: ImageBanner(medium: "https://example.com/medium2.jpg", original: "https://example.com/original2.jpg"),
                summary: "The trials and tribulations of criminal lawyer Jimmy McGill in the time before he established his strip-mall law office in Albuquerque, New Mexico.",
                updated: 1631234568,
                links: LinksReference(linksSelf: LinkReference(href: "https://api.tvmaze.com/shows/2", name: nil), previousEpisode: LinkReference(href: "https://api.tvmaze.com/episodes/2", name: nil))
            )
        ]
    }
}

extension TVShowSearched {
    static func mock() -> TVShowSearched {
        return .init(
            score: 0,
            show: TVShow.mockShows()[0]
        )
    }
}
