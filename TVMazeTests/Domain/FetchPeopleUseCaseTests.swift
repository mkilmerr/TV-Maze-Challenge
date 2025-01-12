//
//  FetchPeopleUseCaseTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class FetchPeopleUseCaseTests: XCTestCase {
    func test_execute_whenSucceeds_shouldReturnPeople() async throws {
        let (sut, repositoryMock) = makeSUT()
        let expectedPeople = PersonSearched.mock()
        repositoryMock.result = expectedPeople
        let testName = "test"

        let people = try await sut.execute(name: testName)

        XCTAssertEqual(people, expectedPeople)
        XCTAssertEqual(repositoryMock.searchName, testName)
    }
    
    func test_execute_whenFails_shouldThrowError() async {
        let (sut, repositoryMock) = makeSUT()
        let expectedError = NSError(domain: "test", code: -1)
        repositoryMock.error = expectedError

        do {
            _ = try await sut.execute(name: "test")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

// MARK: - SUT
extension FetchPeopleUseCaseTests {
    func makeSUT() -> (FetchPeopleUseCase, FetchPeopleRepositoryMock) {
        let repositoryMock = FetchPeopleRepositoryMock()
        let sut = FetchPeopleUseCase(repository: repositoryMock)
        return (sut, repositoryMock)
    }
}
