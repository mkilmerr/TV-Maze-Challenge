//
//  BiometricAuthentication.swift
//  TVMaze
//
//  Created by longarinas on 10/01/25.
//

import Foundation
import LocalAuthentication

public enum BiometricType {
    case none
    case touchID
    case faceID
    case opticID
}

public protocol BiometricAuthenticationProtocol {
    func biometricType() -> BiometricType
    func biometricError(_ error: LAError) -> BiometricAuthenticationError
    func authenticate(with reason: String) async throws
}

final class BiometricAuthentication: BiometricAuthenticationProtocol {
    private let context: LAContext
    
    init(context: LAContext = LAContext()) {
        self.context = context
    }

    func biometricType() -> BiometricType {
        var error: NSError?
        guard context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) else {
            return .none
        }
        
        switch context.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        case .opticID:
            return .opticID
        @unknown default:
            return .none
        }
    }
    
    func biometricError(_ error: LAError) -> BiometricAuthenticationError {
        switch error.code {
        case .authenticationFailed:
            return .failed
        case .userCancel:
            return .cancel
        case .userFallback:
            return .fallBack
        case .biometryNotAvailable:
            return .notAvailable
        case .biometryNotEnrolled:
            return .notEnrolled
        case .biometryLockout:
            return .lockout
        default:
            return .unknown
        }
    }
    
    func authenticate(with reason: String) async throws {
        guard biometricType() != .none else {
            throw BiometricAuthenticationError.notAvailable
        }
        
        do {
            let success = try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            )
            
            if !success {
                throw BiometricAuthenticationError.failed
            }
        } catch let error as LAError {
            throw biometricError(error)
        } catch {
            throw BiometricAuthenticationError.unknown
        }
    }
}
