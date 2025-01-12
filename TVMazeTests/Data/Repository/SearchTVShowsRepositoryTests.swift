//
//  SearchTVShowsRepositoryTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class SearchTVShowsRepositoryTests: XCTestCase {
    func test_fetchTVShows_whenSucceeds_shouldReturnTVShows() async throws {
        let (sut, networkClientMock) = makeSUT()
        let expectedShows = [TVShowSearched.mock()]
        networkClientMock.result = expectedShows
        let testName = "test"

        let shows = try await sut.fetchTVShows(by: testName)

        XCTAssertEqual(shows, expectedShows)
    }
    
    func test_fetchTVShows_whenFails_shouldThrowError() async {
        let (sut, networkClientMock) = makeSUT()
        let expectedError = NSError(domain: "test", code: -1)
        networkClientMock.error = expectedError

        do {
            _ = try await sut.fetchTVShows(by: "test")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

// MARK: - SUT
extension SearchTVShowsRepositoryTests {
    func makeSUT() -> (SearchTVShowsRepository, NetworkClientMock) {
        let networkClientMock = NetworkClientMock()
        let sut = SearchTVShowsRepository(networkClient: networkClientMock)
        return (sut, networkClientMock)
    }
}

