//
//  BiometricAuthenticationError.swift
//  TVMaze
//
//  Created by longarinas on 10/01/25.
//

import Foundation

public enum BiometricAuthenticationError: LocalizedError {
    case failed
    case cancel
    case fallBack
    case notAvailable
    case notEnrolled
    case lockout
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .failed: return "There was a problem verifying your identity."
        case .cancel: return "Authentication was canceled by user."
        case .fallBack: return "User chose to use fallback authentication."
        case .notAvailable: return "Biometric authentication is not available."
        case .notEnrolled: return "Biometric authentication is not set up."
        case .lockout: return "Biometric authentication is locked out."
        case .unknown: return "Unknown error occurred."
        }
    }
}
