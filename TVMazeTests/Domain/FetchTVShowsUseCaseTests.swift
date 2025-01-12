//
//  FetchTVShowsUseCaseTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class FetchTVShowsUseCaseTests: XCTestCase {
    func test_execute_whenSucceeds_shouldReturnTVShows() async throws {
        let (sut, repositoryMock) = makeSUT()
        
        let expectedShows = TVShow.mockShows()
        repositoryMock.result = expectedShows
        
        let shows = try await sut.execute(page: 0)
        
        XCTAssertEqual(shows, expectedShows)
        XCTAssertEqual(repositoryMock.page, 0)
    }
    
    func test_execute_whenFails_shouldThrowError() async {
        let (sut, repositoryMock) = makeSUT()

        let expectedError = NSError(domain: "test", code: -1)
        repositoryMock.error = expectedError

        do {
            _ = try await sut.execute(page: 0)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

extension FetchTVShowsUseCaseTests {
    func makeSUT() -> (FetchTVShowsUseCase, TVShowsRepositoryMock) {
        let repositoryMock = TVShowsRepositoryMock()
        let sut = FetchTVShowsUseCase(repository: repositoryMock)
        return (sut, repositoryMock)
    }
}
