//
//  SearchTVShowsEndpoint.swift
//  TVMaze
//
//  Created by longarinas on 11/01/25.
//

import Foundation

struct SearchTVShowsEndpoint: Endpoint {
    let name: String

    init(name: String) {
        self.name = name
    }

    var path: String {
        return "/search/shows"
    }
    
    var method: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "q", value: name)]
    }
}
