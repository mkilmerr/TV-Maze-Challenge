//
//  TVShowDetailViewModelTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class TVShowDetailViewModelTests: XCTestCase {
    func test_loadSeasons_whenSucceeds_shouldUpdateEpisodes() async {
        let (sut, useCase) = makeSUT()
        let episodes = [
            Episode.mockUnitTest(season: 1, number: 1),
            Episode.mockUnitTest(season: 1, number: 2),
            Episode.mockUnitTest(season: 2, number: 1)
        ]
        useCase.result = episodes
        
        await sut.loadEpisodes()
        
        XCTAssertEqual(sut.episodes.count, 2)
        XCTAssertEqual(sut.episodes[0].seasonNumber, 1)
        XCTAssertEqual(sut.episodes[0].episodes.count, 2)
        XCTAssertEqual(sut.episodes[1].seasonNumber, 2)
        XCTAssertEqual(sut.episodes[1].episodes.count, 1)
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.isError)
    }
    
    func test_loadSeasons_whenFails_shouldSetError() async {
        let (sut, useCase) = makeSUT()
        let expectedError = NSError(domain: "test", code: -1)
        useCase.error = expectedError

        await sut.loadEpisodes()

        XCTAssertTrue(sut.episodes.isEmpty)
        XCTAssertFalse(sut.isLoading)
       
    }
}

// MARK: - SUT
extension TVShowDetailViewModelTests {
    func makeSUT() -> (TVShowDetailViewModel, FetchTVShowEpisodesUseCaseMock) {
        let useCase = FetchTVShowEpisodesUseCaseMock()
        let show = TVShow.mockShows()[0]
        let sut = TVShowDetailViewModel(fetchEpisodesUseCase: useCase, show: show)
        return (sut, useCase)
    }
}

extension Episode {
    static func mockUnitTest(season: Int = 1, number: Int = 1) -> Episode {
        Episode(
                 id: 34,
                 url: "https://www.tvmaze.com/episodes/test",
                 name: "Test Episode",
                 season: season,
                 number: number,
                 type: "regular",
                 airdate: "2024-01-11",
                 airtime: "20:00",
                 airstamp: "2024-01-11T20:00:00+00:00",
                 runtime: 30,
                 rating: Rating(average: 8.5),
                 image: ImageBanner(
                     medium: "https://test.com/medium.jpg",
                     original: "https://test.com/original.jpg"
                 ),
                 summary: "Test episode summary",
                 links: LinksReference(
                    linksSelf: .init(href: "", name: nil),
                     previousEpisode: nil
                 )
             )
    }
}
