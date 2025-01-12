//
//  TVShowSeasonsEndpoint.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct TVShowEpisodesEndpoint: Endpoint {
    let id: Int

    init(id: Int) {
        self.id = id
    }

    var path: String {
        return "/shows/\(id)/episodes"
    }
    
    var method: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }
}
