//
//  PeopleEndpoint.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct PeopleEndpoint: Endpoint {
    let name: String

    init(name: String) {
        self.name = name
    }

    var path: String {
        return "/search/people"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "q", value: String(name))]
    }
}
