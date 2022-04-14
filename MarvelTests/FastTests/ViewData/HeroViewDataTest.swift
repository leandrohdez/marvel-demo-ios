//
//  HeroViewDataTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class HeroViewDataTest: XCTestCase {

    private let heroName: String            = "Superhero"
    private let heroImage: String           = "https://via.placeholder.com/80"
    private let heroDescription: String     = "Marvel superhero description"
    
    var sut: HeroViewData!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = HeroViewData(id: 1, name: self.heroName, avatarURL: URL(string: self.heroImage), description: self.heroDescription)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - UnitTest Methods
extension HeroViewDataTest {
    
    //
    func testViewDataValid() throws {
        XCTAssertEqual(self.sut.id, 1, "Bad object initialization")
        XCTAssertEqual(self.sut.name, self.heroName, "Bad object initialization")
        XCTAssertEqual(self.sut.avatarURL?.absoluteString, self.heroImage, "Bad object initialization")
        XCTAssertEqual(self.sut.description, self.heroDescription, "Bad object initialization")
    }
    
}

// MARK: - Performance Methods
extension HeroViewDataTest {
    
    //
    func testInitializationPerformance() throws {
        measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric()]) {
            self.sut = HeroViewData(id: 1, name: self.heroName, avatarURL: URL(string: self.heroImage), description: self.heroDescription)
        }
    }
    
}
