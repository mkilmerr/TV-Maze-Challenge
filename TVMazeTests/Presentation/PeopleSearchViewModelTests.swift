//
//  PeopleSearchViewModelTests.swift
//  TVMazeTests
//
//  Created by longarinas on 11/01/25.
//

import XCTest
@testable import TVMaze

final class PeopleSearchViewModelTests: XCTestCase {
    func test_search_whenNameIsEmpty_shouldClearPeople() async {
        let (sut, _) = makeSUT()
        sut.people = PersonSearched.mock()

        await sut.search(by: "")

        XCTAssertTrue(sut.people.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.isError)
    }
    
    func test_search_whenSucceeds_shouldUpdatePeople() async {
        let (sut, useCase) = makeSUT()
        let expectedPeople = PersonSearched.mock()
        useCase.result = expectedPeople

        await sut.search(by: "test")

        XCTAssertEqual(sut.people, expectedPeople)
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.isError)
    }
    
    func test_search_whenFails_shouldClearPeopleAndShowError() async {
        let (sut, useCase) = makeSUT()
        sut.people = PersonSearched.mock()
        useCase.error = NSError(domain: "test", code: -1)

        await sut.search(by: "test")

        XCTAssertTrue(sut.people.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.isError)
    }

    func test_personSelected_whenSet_shouldUpdateState() {
        let (sut, _) = makeSUT()
        let person = Person.mock()

        sut.personSelected = person

        XCTAssertEqual(sut.personSelected, person)
    }
}

// MARK: - SUT
extension PeopleSearchViewModelTests {
    func makeSUT() -> (PeopleSearchViewModel, FetchPeopleUseCaseMock) {
        let useCase = FetchPeopleUseCaseMock()
        let sut = PeopleSearchViewModel(fetchPeopleUseCase: useCase)
        return (sut, useCase)
    }
}
