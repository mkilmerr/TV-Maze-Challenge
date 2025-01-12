//
//  SearchTVShowsUseCaseTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class SearchTVShowsUseCaseTests: XCTestCase {
    func test_execute_whenSucceeds_shouldReturnTVShows() async throws {
        let (sut, repositoryMock) = makeSUT()
        let expectedShows = [TVShowSearched.mock()]
        repositoryMock.result = expectedShows
        let testName = "test"

        let shows = try await sut.execute(name: testName)

        XCTAssertEqual(shows, expectedShows)
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
extension SearchTVShowsUseCaseTests {
    func makeSUT() -> (SearchTVShowsUseCase, SearchTVShowsRepositoryMock) {
        let repositoryMock = SearchTVShowsRepositoryMock()
        let sut = SearchTVShowsUseCase(repository: repositoryMock)
        return (sut, repositoryMock)
    }
}
