//
//  BiometricAuthenticationUseCase.swift
//  TVMaze
//
//  Created by longarinas on 10/01/25.
//

import Foundation

//MARK: UseCase
protocol BiometricAuthenticationUseCaseProtocol {
    func authenticate() async throws
    func isBiometricAvailable() -> Bool
}

final class BiometricAuthenticationUseCase: BiometricAuthenticationUseCaseProtocol {
    private let biometricAuth: BiometricAuthenticationProtocol
    
    init(biometricAuth: BiometricAuthenticationProtocol) {
        self.biometricAuth = biometricAuth
    }
    
    func authenticate() async throws {
        try await biometricAuth.authenticate(with: "Authenticate to access the app")
    }
    
    func isBiometricAvailable() -> Bool {
        return biometricAuth.biometricType() != .none
    }
}

// MARK: Mock
final class BiometricAuthenticationUseCaseMock: BiometricAuthenticationUseCaseProtocol {
    var authenticateCalled: Bool = false
    let available: Bool
    
    init(available: Bool = false) {
        self.available = available
    }
    
    func authenticate() async throws {
        authenticateCalled.toggle()
    }
    
    func isBiometricAvailable() -> Bool {
        available
    }
}
