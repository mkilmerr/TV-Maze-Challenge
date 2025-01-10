//
//  BiometricAuthenticationViewModel+Factory.swift
//  TVMaze
//
//  Created by longarinas on 10/01/25.
//

import Foundation

extension BiometricAuthenticationViewModel {
    static func make() -> BiometricAuthenticationViewModel {
        let authentication = BiometricAuthentication()

        let authenticationUseCase = BiometricAuthenticationUseCase(
            biometricAuth: authentication
        )

        return .init(authenticationUseCase: authenticationUseCase)
    }
}
