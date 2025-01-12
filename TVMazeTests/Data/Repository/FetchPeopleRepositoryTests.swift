//
//  FetchPeopleRepositoryTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class FetchPeopleRepositoryTests: XCTestCase {
    func test_fetchPeople_whenSucceeds_shouldReturnPeople() async throws {
        let (sut, networkClientMock) = makeSUT()
        let expectedPeople = PersonSearched.mock()
        networkClientMock.result = expectedPeople

        let people = try await sut.fetchPeople(name: "test")

        XCTAssertEqual(people, expectedPeople)
    }
    
    func test_fetchPeople_whenFails_shouldThrowError() async {
        let (sut, networkClientMock) = makeSUT()
        let expectedError = NSError(domain: "test", code: -1)
        networkClientMock.error = expectedError

        do {
            _ = try await sut.fetchPeople(name: "test")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

// MARK: - SUT
extension FetchPeopleRepositoryTests {
    func makeSUT() -> (FetchPeopleRepository, NetworkClientMock) {
        let networkClientMock = NetworkClientMock()
        let sut = FetchPeopleRepository(networkClient: networkClientMock)
        return (sut, networkClientMock)
    }
}

