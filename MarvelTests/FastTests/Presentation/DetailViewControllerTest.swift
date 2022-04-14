//
//  DetailViewControllerTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class DetailViewControllerTest: XCTestCase {

    var sut: DetailViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = DetailViewController(nibName: "DetailViewController", bundle: Bundle.main)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

//
extension DetailViewControllerTest {
    
    //
    func testControllerLebelsTextValid() {
        
        // given
        self.sut.detailPresenter = MockDetailPresenter(
            view: self.sut,
            usecases: DetailPresenter.UseCases(
                hero: MockHeroUseCaseSuccess()
            )
        )
        
        // when
        let fakeHero = Hero(id: 1, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        self.sut.presenter.hero = fakeHero
        self.sut.presenter.viewDidLoad()
        
        // then
        XCTAssertFalse((self.sut.nameLabel.text ?? "").isEmpty, "The string should not be empty")
        XCTAssertEqual(self.sut.nameLabel.text ?? "", fakeHero.name, "The objects should be the equals")
        
        XCTAssertFalse((self.sut.descriptionLabel.text ?? "").isEmpty, "The string should not be empty")
        XCTAssertEqual(self.sut.descriptionLabel.text ?? "", fakeHero.description, "The objects should be the equals")
        
        XCTAssertEqual(self.sut.comicsCollectionView.numberOfItems(inSection: 0), 0, "The array should have 0 items")
        XCTAssertEqual(self.sut.seriesCollectionView.numberOfItems(inSection: 0), 0, "The array should have 0 items")
        XCTAssertEqual(self.sut.storiesCollectionView.numberOfItems(inSection: 0), 0, "The array should have 0 items")
    }
    
    //
    func testControllerCollectionsViewBehaivorsValid() {
        
        // given
        self.sut.detailPresenter = MockDetailPresenter(
            view: self.sut,
            usecases: DetailPresenter.UseCases(
                hero: MockHeroUseCaseSuccess()
            )
        )
        
        // when
        let fakeHero = Hero(id: 1, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        self.sut.presenter.hero = fakeHero
        self.sut.presenter.viewDidLoad()
        
        // then
        XCTAssertEqual(self.sut.comicsCollectionView.numberOfItems(inSection: 0), 0, "The array should have 0 items")
        XCTAssertEqual(self.sut.seriesCollectionView.numberOfItems(inSection: 0), 0, "The array should have 0 items")
        XCTAssertEqual(self.sut.storiesCollectionView.numberOfItems(inSection: 0), 0, "The array should have 0 items")
    }
    
}
