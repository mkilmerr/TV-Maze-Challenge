//
//  BiometricAuthenticationUseCaseMock.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import Foundation
@testable import TVMaze

final class BiometricAuthenticationUseCaseMock: BiometricAuthenticationUseCaseProtocol {
    var error: Error?
    var isBiometricAvailableResult = true
    
    func authenticate() async throws {
        if let error = error {
            throw error
        }
    }
    
    func isBiometricAvailable() -> Bool {
        isBiometricAvailableResult
    }
}
