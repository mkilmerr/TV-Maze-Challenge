//
//  Endpoint.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}
