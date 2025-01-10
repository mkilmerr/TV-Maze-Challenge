//
//  PeopleEndpoint.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct PeopleEndpoint: Endpoint {
    let page: Int

    init(page: Int) {
        self.page = page
    }

    var path: String {
        return "/people"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "page", value: String(page))]
    }
}
