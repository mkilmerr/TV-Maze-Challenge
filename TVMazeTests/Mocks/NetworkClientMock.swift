//
//  NetworkClientMock.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import Foundation
@testable import TVMaze

final class NetworkClientMock: HTTPClient {
    var result: Any?
    var error: Error?
    
    func request<T:Decodable>(_ endpoint: Endpoint) async throws -> T {
        if let error = error {
            throw error
        }
        
        guard let result = result as? T else {
            fatalError("Result type mismatch")
        }
        
        return result
    }
}
