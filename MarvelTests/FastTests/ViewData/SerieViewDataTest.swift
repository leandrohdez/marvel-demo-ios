//
//  SerieViewDataTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class SerieViewDataTest: XCTestCase {

    private let serieTitle: String          = "Serie Title"
    private let serieImage: String          = "https://via.placeholder.com/80"
    
    var sut: SerieViewData!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = SerieViewData(id: 1, title: self.serieTitle, coverURL: URL(string: self.serieImage))
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - UnitTest Methods
extension SerieViewDataTest {
    
    //
    func testViewModelDataValid() throws {
        XCTAssertEqual(self.sut.id, 1, "Bad object initialization")
        XCTAssertEqual(self.sut.title, self.serieTitle, "Bad object initialization")
        XCTAssertEqual(self.sut.coverURL?.absoluteString, self.serieImage, "Bad object initialization")
    }
    
}

// MARK: - Performance Methods
extension SerieViewDataTest {
    
    //
    func testInitializationPerformance() throws {
        measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric()]) {
            self.sut = SerieViewData(id: 1, title: self.serieTitle, coverURL: URL(string: self.serieImage))
        }
    }
    
}
