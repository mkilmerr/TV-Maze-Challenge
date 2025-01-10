//
//  GuestCastCreditEndpoint.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

struct GuestCastCreditEndpoint: Endpoint {
    let id: Int

    init(id: Int) {
        self.id = id
    }

    var path: String {
        return "/people/\(id)/guestcastcredits"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
