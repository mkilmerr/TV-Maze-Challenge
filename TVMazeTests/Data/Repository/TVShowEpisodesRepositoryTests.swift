//
//  TVShowEpisodesRepositoryTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class TVShowEpisodesRepositoryTests: XCTestCase {
    func test_fetchEpisodes_whenSucceeds_shouldReturnEpisodes() async throws {
        let (sut, networkClientMock) = makeSUT()
        let expectedEpisodes = [Episode.mock()]
        networkClientMock.result = expectedEpisodes

        let episodes = try await sut.fetchEpisodes(by: 1)

        XCTAssertEqual(episodes, expectedEpisodes)
    }
    
    func test_fetchEpisodes_whenFails_shouldThrowError() async {
        let (sut, networkClientMock) = makeSUT()
        let expectedError = NSError(domain: "test", code: -1)
        networkClientMock.error = expectedError

        do {
            _ = try await sut.fetchEpisodes(by: 1)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

// MARK: - SUT
extension TVShowEpisodesRepositoryTests {
    func makeSUT() -> (TVShowEpisodesRepository, NetworkClientMock) {
        let networkClientMock = NetworkClientMock()
        let sut = TVShowEpisodesRepository(networkClient: networkClientMock)
        return (sut, networkClientMock)
    }
}
