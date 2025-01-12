//
//  TVShowsRepositoryTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class TVShowsRepositoryTests: XCTestCase {
    func test_fetchShows_whenSucceeds_shouldReturnTVShows() async throws {
        let (sut, networkClientMock) = makeSUT()
        let expectedShows = TVShow.mockShows()
        networkClientMock.result = expectedShows

        let shows = try await sut.fetchShows(page: 0)
        
        XCTAssertEqual(shows, expectedShows)
    }
    
    func test_fetchShows_whenFails_shouldThrowError() async {
        let (sut, networkClientMock) = makeSUT()
        let expectedShows = TVShow.mockShows()
        
        let expectedError = NSError(domain: "test", code: -1)
        networkClientMock.error = expectedError
        
        // When/Then
        do {
            _ = try await sut.fetchShows(page: 0)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

// MARK: SUT
extension TVShowsRepositoryTests {
    func makeSUT() -> (TVShowsRepository, NetworkClientMock) {
        let networkClientMock = NetworkClientMock()
        let sut = TVShowsRepository(networkClient: networkClientMock)
        return (sut, networkClientMock)
    }
}
