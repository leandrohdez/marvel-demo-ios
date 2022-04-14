//
//  DetailPresenterTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class DetailPresenterTest: XCTestCase {

    var sut: DetailPresenter!
    
    var mockController: MockDetailController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.mockController = MockDetailController()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.mockController = nil
        try super.tearDownWithError()
    }

}

// MARK: - Performing behaivors
extension DetailPresenterTest {
    
    // performing data with items
    func testPresenterPerformDataItem() throws {
        
        // given
        self.sut = DetailPresenter(
            view: self.mockController,
            usecases: DetailPresenter.UseCases(
                hero: MockHeroUseCaseSuccess()
            )
        )
        
        self.mockController.presenter = self.sut
        
        // when
        self.sut.hero = Hero(id: 1, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        self.sut.viewDidLoad()
        
        // then
        XCTAssertNotNil(self.mockController.heroViewData, "The object should not be Nil")
    }
    
    // not performing data
    func testPresenterNoPerformData() throws {
        
        // given
        self.sut = DetailPresenter(
            view: self.mockController,
            usecases: DetailPresenter.UseCases(
                hero: MockHeroUseCaseFail()
            )
        )
        
        self.mockController.presenter = self.sut
        
        // when
        self.sut.hero = Hero(id: 1, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        self.sut.viewDidLoad()
        
        // then
        XCTAssertNotNil(self.mockController.heroViewData, "The object should not be Nil")
    }
}
