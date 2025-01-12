//
//  FetchTVShowEpisodesUseCaseTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class FetchTVShowEpisodesUseCaseTests: XCTestCase {
    func test_execute_whenSucceeds_shouldReturnEpisodes() async throws {
        let (sut, repositoryMock) = makeSUT()
        let expectedEpisodes = [Episode.mock()]
        repositoryMock.result = expectedEpisodes

        let episodes = try await sut.execute(id: 1)

        XCTAssertEqual(episodes, expectedEpisodes)
        XCTAssertEqual(repositoryMock.seasonId, 1)
    }
    
    func test_execute_whenFails_shouldThrowError() async {
        let (sut, repositoryMock) = makeSUT()
        let expectedError = NSError(domain: "test", code: -1)
        repositoryMock.error = expectedError

        do {
            _ = try await sut.execute(id: 1)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

// MARK: - SUT
extension FetchTVShowEpisodesUseCaseTests {
    func makeSUT() -> (FetchTVShowEpisodesUseCase, TVShowEpisodesRepositoryMock) {
        let repositoryMock = TVShowEpisodesRepositoryMock()
        let sut = FetchTVShowEpisodesUseCase(repository: repositoryMock)
        return (sut, repositoryMock)
    }
}
