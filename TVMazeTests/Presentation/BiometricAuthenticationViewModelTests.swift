//
//  BiometricAuthenticationViewModelTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class BiometricAuthenticationViewModelTests: XCTestCase {
    func test_authenticate_whenSucceeds_shouldSetIsAuthenticatedToTrue() async {
        let (sut, _) = makeSUT()
        await sut.authenticate()

        XCTAssertTrue(sut.isAuthenticated)
        XCTAssertNil(sut.error)
    }
    
    func test_authenticate_whenFails_shouldSetError() async {
        let (sut, authUseCaseMock) = makeSUT()
        authUseCaseMock.error = BiometricAuthenticationError.notAvailable
        await sut.authenticate()

        XCTAssertFalse(sut.isAuthenticated)
        XCTAssertEqual(sut.error, BiometricAuthenticationError.notAvailable.localizedDescription)
    }
    
    func test_authenticate_whenUnknownError_shouldSetUnknownError() async {
        let (sut, authUseCaseMock) = makeSUT()
        authUseCaseMock.error = NSError(domain: "test", code: -1)
        await sut.authenticate()

        XCTAssertFalse(sut.isAuthenticated)
        XCTAssertEqual(sut.error, BiometricAuthenticationError.unknown.localizedDescription)
    }
    
    func test_isBiometricAvailable_whenAvailable_shouldReturnTrue() {
        let (sut, authUseCaseMock) = makeSUT()
        authUseCaseMock.isBiometricAvailableResult = true

        let result = sut.isBiometricAvailable

        XCTAssertTrue(result)
    }
    
    func test_isBiometricAvailable_whenNotAvailable_shouldReturnFalse() {
        let (sut, authUseCaseMock) = makeSUT()
        authUseCaseMock.isBiometricAvailableResult = false

        let result = sut.isBiometricAvailable

        XCTAssertFalse(result)
    }
}

// MARK: - SUT
extension BiometricAuthenticationViewModelTests {
    func makeSUT() -> (BiometricAuthenticationViewModel, BiometricAuthenticationUseCaseMock) {
        let authUseCaseMock = BiometricAuthenticationUseCaseMock()
        let sut = BiometricAuthenticationViewModel(authenticationUseCase: authUseCaseMock)
        return (sut, authUseCaseMock)
    }
}
