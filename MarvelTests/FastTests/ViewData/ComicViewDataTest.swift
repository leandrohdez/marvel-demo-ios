//
//  ComicViewDataTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class ComicViewDataTest: XCTestCase {
    
    private let comicTitle: String          = "Comic Title"
    private let comicImage: String          = "https://via.placeholder.com/80"
    
    var sut: ComicViewData!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = ComicViewData(id: 1, title: self.comicTitle, coverURL: URL(string: self.comicImage))
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - UnitTest Methods
extension ComicViewDataTest {
    
    //
    func testViewDataValid() throws {
        XCTAssertEqual(self.sut.id, 1, "Bad object initialization")
        XCTAssertEqual(self.sut.title, self.comicTitle, "Bad object initialization")
        XCTAssertEqual(self.sut.coverURL?.absoluteString, self.comicImage, "Bad object initialization")
    }
    
}

// MARK: - Performance Methods
extension ComicViewDataTest {
    
    //
    func testInitializationPerformance() throws {
        measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric()]) {
            self.sut = ComicViewData(id: 1, title: self.comicTitle, coverURL: URL(string: self.comicImage))
        }
    }
    
}
