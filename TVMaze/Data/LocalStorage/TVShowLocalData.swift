//
//  TVShowLocalData.swift
//  TVMaze
//
//  Created by longarinas on 11/01/25.
//

import Foundation
import SwiftData

protocol TVShowRepresentable {
    var id: Int { get }
    var name: String { get }
    var genres: [String] { get }
    var summary: String? { get }
    var premiered: String? { get }
    var ended: String? { get }
    var remoteImage: String? { get }
    var average: Double? { get }
    var scheduleDays: [String]? { get }
    var status: String { get }
    var time: String { get }
}

@Model
final class TVShowLocalData: TVShowRepresentable {
    let id: Int
    let name: String
    let summary: String?
    let genres: [String]
    let average: Double?
    let premiered: String?
    let ended: String?
    var remoteImage: String?
    var scheduleDays: [String]?
    var status: String
    var time: String

    init(
        id: Int,
        name: String,
        remoteImage: String?,
        summary: String?,
        genres: [String],
        average: Double?,
        premiered: String?,
        ended: String?,
        scheduleDays: [String]?,
        status: String,
        time: String
    ) {
        self.id = id
        self.name = name
        self.remoteImage = remoteImage
        self.summary = summary
        self.genres = genres
        self.average = average
        self.premiered = premiered
        self.ended = ended
        self.scheduleDays = scheduleDays
        self.status = status
        self.time = time
    }

    convenience init(from tvShow: TVShow) {
        self.init(
            id: tvShow.id,
            name: tvShow.name,
            remoteImage: tvShow.image?.original,
            summary: tvShow.summary,
            genres: tvShow.genres,
            average: tvShow.rating.average,
            premiered: tvShow.premiered,
            ended: tvShow.ended,
            scheduleDays: tvShow.schedule.days,
            status: tvShow.status,
            time: tvShow.schedule.time
        )
    }
    
    func toTVShow() -> TVShow {
        return TVShow(
            id: id,
            url: "",
            name: name,
            type: "",
            language: "",
            genres: genres,
            status: status,
            runtime: nil,
            averageRuntime: nil,
            premiered: premiered,
            ended: ended,
            officialSite: nil,
            schedule: Schedule(
                time: time,
                days: scheduleDays ?? []
            ),
            rating: Rating(average: average),
            weight: 0,
            network: nil,
            webChannel: nil,
            dvdCountry: nil,
            externals: Externals(tvrage: 0, thetvdb: 0, imdb: ""),
            image: remoteImage.map { ImageBanner(medium: $0, original: $0) },
            summary: summary,
            updated: 0,
            links: LinksReference(
                linksSelf: LinkReference(href: "", name: nil),
                previousEpisode: nil
            )
        )
    }
}
