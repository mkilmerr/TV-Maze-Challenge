//
//  TVShowsEndpoint.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct TVShowsEndpoint: Endpoint {
    let page: Int

    init(page: Int) {
        self.page = page
    }

    var path: String {
        return "/shows"
    }
    
    var method: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "page", value: String(page))]
    }
}
