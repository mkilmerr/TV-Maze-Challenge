//
//  NetworkError.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
}
