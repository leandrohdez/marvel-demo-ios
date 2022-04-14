//
//  MainViewControllerTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class MainViewControllerTest: XCTestCase {

    var sut: MainViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = MainViewController(nibName: "MainViewController", bundle: Bundle.main)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

//
extension MainViewControllerTest {
    
    //
    func testControllerTableViewLoadItemsBehaivorValid() throws {

        // given
        self.sut.mainPresenter = MockMainPresenter(
            view: self.sut,
            usecases: MainPresenter.UseCases(
                heroes: MockHeroesUseCaseSuccess(),
                topFive: MockTopFiveUseCaseSuccess()
            )
        )

        // when
        self.sut.presenter.viewDidLoad()

        // then
        XCTAssertTrue((self.sut.tableView.numberOfRows(inSection: 0) > 0), "The tableView must not be empty")
    }
    
    //
    func testControllerTableViewLoadMoreItemsBehaivorValid() throws {
        
        // given
        self.sut.mainPresenter = MockMainPresenter(
            view: self.sut,
            usecases: MainPresenter.UseCases(
                heroes: MockHeroesUseCaseSuccess(),
                topFive: MockTopFiveUseCaseSuccess()
            )
        )
        
        // when
        self.sut.presenter.viewDidLoad()
        let totalItems = self.sut.tableView.numberOfRows(inSection: 0)
        self.sut.tableView.scrollToRow(at: IndexPath(row: totalItems-1, section: 0), at: .bottom, animated: false)
        
        // then
        XCTAssertTrue((self.sut.tableView.numberOfRows(inSection: 0) > totalItems), "The tableView should have more items")
    }
}
