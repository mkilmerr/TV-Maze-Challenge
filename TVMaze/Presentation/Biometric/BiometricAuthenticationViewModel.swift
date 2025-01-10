//
//  BiometricAuthenticationViewModel.swift
//  TVMaze
//
//  Created by longarinas on 10/01/25.
//

import SwiftUI

@MainActor
final class BiometricAuthenticationViewModel: ObservableObject {
    @Published private(set) var isAuthenticated = false
    @Published private(set) var error: String?
    
    private let authenticationUseCase: BiometricAuthenticationUseCaseProtocol
    
    init(authenticationUseCase: BiometricAuthenticationUseCaseProtocol) {
        self.authenticationUseCase = authenticationUseCase
    }
    
    var isBiometricAvailable: Bool {
        authenticationUseCase.isBiometricAvailable()
    }
    
    func authenticate() async {
        do {
            try await authenticationUseCase.authenticate()
            isAuthenticated = true
            error = nil
        } catch let authError as BiometricAuthenticationError {
            error = authError.localizedDescription
        } catch {
            self.error = BiometricAuthenticationError.unknown.localizedDescription
        }
    }
}
