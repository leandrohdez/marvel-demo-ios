//
//  MainPresenterTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class MainPresenterTest: XCTestCase {

    var sut: MainPresenter!
    
    var mockController: MockMainController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.mockController = MockMainController()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.mockController = nil
        try super.tearDownWithError()
    }

}

// MARK: - Performing behaivor 
extension MainPresenterTest {
    
    // performing data with items
    func testPresenterPerformDataWithItems() throws {
        
        // given
        self.sut = MainPresenter(
            view: self.mockController,
            usecases: MainPresenter.UseCases(
                heroes: MockHeroesUseCaseSuccess(),
                topFive: MockTopFiveUseCaseSuccess()
            )
        )
        
        self.mockController.presenter = self.sut
        
        // when
        self.sut.viewDidLoad()
        
        // then
        XCTAssertNotNil(self.mockController.heroesViewData, "The object should not be Nil")
        XCTAssertNotNil(self.mockController.mostPopularHeroes, "The object should not be Nil")
        
        guard let heroesViewData = self.mockController.heroesViewData else {
            return XCTFail("The object should not be Nil")
        }
        
        XCTAssertFalse(heroesViewData.isEmpty, "The array must not be empty")
        XCTAssertEqual(heroesViewData.count, 10, "The array should have 10 items")
        
        guard let mostPopularHeroes = self.mockController.mostPopularHeroes else {
            return XCTFail("The object should not be Nil")
        }
        
        XCTAssertFalse(mostPopularHeroes.isEmpty, "The array must not be empty")
        XCTAssertEqual(mostPopularHeroes.count, 5, "The array should have 5 items")
    }
    
    // performing data empty
    func testPresenterPerformDataEmpty() throws {
        
        // given
        self.sut = MainPresenter(
            view: self.mockController,
            usecases: MainPresenter.UseCases(
                heroes: MockHeroesUseCaseEmpty(),
                topFive: MockTopFiveUseCaseEmpty()
            )
        )
        
        self.mockController.presenter = self.sut
        
        // when
        self.sut.viewDidLoad()
        
        // then
        XCTAssertNotNil(self.mockController.heroesViewData, "The object should not be Nil")
        XCTAssertNotNil(self.mockController.mostPopularHeroes, "The object should not be Nil")
        
        guard let heroesViewData = self.mockController.heroesViewData else {
            return XCTFail("The object should not be Nil")
        }
        
        XCTAssertTrue(heroesViewData.isEmpty, "The array must be empty")
        
        guard let mostPopularHeroes = self.mockController.mostPopularHeroes else {
            return XCTFail("The object should not be Nil")
        }
        
        XCTAssertTrue(mostPopularHeroes.isEmpty, "The array must be empty")
    }
    
    // not performing data
    func testPresenterNoPerformData() throws {
        
        // given
        self.sut = MainPresenter(
            view: self.mockController,
            usecases: MainPresenter.UseCases(
                heroes: MockHeroesUseCaseFail(),
                topFive: MockTopFiveUseCaseFail()
            )
        )
        
        self.mockController.presenter = self.sut
        
        // when
        self.sut.viewDidLoad()
        
        // then
        XCTAssertNil(self.mockController.heroesViewData, "The object should not be Nil")
        XCTAssertNil(self.mockController.mostPopularHeroes, "The object should not be Nil")
    }
}
