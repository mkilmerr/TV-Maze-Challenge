//
//  EpisodeItemViewModel.swift
//  TVMaze
//
//  Created by longarinas on 11/01/25.
//

import Foundation

struct EpisodeItemViewModel: Identifiable {
    let id = UUID()
    let seasonNumber: Int
    let episodes: [Episode]
}

//MARK: Mock
extension EpisodeItemViewModel {
    static func mock() -> EpisodeItemViewModel {
        return .init(
            seasonNumber: 1,
            episodes: [Episode.mock()]
        )
    }
}
