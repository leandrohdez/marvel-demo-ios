//
//  StoryViewDataTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class StoryViewDataTest: XCTestCase {

    private let storyTitle: String          = "Story Title"
    private let storyImage: String          = "https://via.placeholder.com/80"
    
    var sut: SerieViewData!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = SerieViewData(id: 1, title: self.storyTitle, coverURL: URL(string: self.storyImage))
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - UnitTest Methods
extension StoryViewDataTest {
    
    //
    func testViewDataValid() throws {
        XCTAssertEqual(self.sut.id, 1, "Bad object initialization")
        XCTAssertEqual(self.sut.title, self.storyTitle, "Bad object initialization")
        XCTAssertEqual(self.sut.coverURL?.absoluteString, self.storyImage, "Bad object initialization")
    }
    
}

// MARK: - Performance Methods
extension StoryViewDataTest {
    
    //
    func testInitializationPerformance() throws {
        measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric()]) {
            self.sut = SerieViewData(id: 1, title: self.storyTitle, coverURL: URL(string: self.storyImage))
        }
    }
    
}
