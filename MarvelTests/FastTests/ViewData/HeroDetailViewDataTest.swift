//
//  HeroDetailViewDataTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class HeroDetailViewDataTest: XCTestCase {

    private let heroName: String                = "Superhero"
    private let heroImage: String               = "https://via.placeholder.com/80"
    private let heroDescription: String         = "Marvel superhero description"
    private let heroComics: [ComicViewData]    = []
    private let heroSeries: [SerieViewData]    = []
    private let heroStories: [StoryViewData]   = []
    
    var sut: HeroDetailViewData!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = HeroDetailViewData(
            id: 1,
            name: self.heroName,
            avatarURL: URL(string: self.heroImage),
            description: self.heroDescription,
            comics: self.heroComics,
            series: self.heroSeries,
            stories: self.heroStories
        )
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - UnitTest Methods
extension HeroDetailViewDataTest {
    
    //
    func testViewDataValid() throws {
        XCTAssertEqual(self.sut.id, 1, "Bad object initialization")
        XCTAssertEqual(self.sut.name, self.heroName, "Bad object initialization")
        XCTAssertEqual(self.sut.avatarURL?.absoluteString, self.heroImage, "Bad object initialization")
        XCTAssertEqual(self.sut.description, self.heroDescription, "Bad object initialization")
        XCTAssertEqual(self.sut.comics.count, self.heroComics.count, "Bad object initialization")
        XCTAssertEqual(self.sut.series.count, self.heroSeries.count, "Bad object initialization")
        XCTAssertEqual(self.sut.stories.count, self.heroStories.count, "Bad object initialization")
    }
    
}

// MARK: - Performance Methods
extension HeroDetailViewDataTest {
    
    //
    func testInitializationPerformance() throws {
        measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric()]) {
            self.sut = HeroDetailViewData(
                id: 1,
                name: self.heroName,
                avatarURL: URL(string: self.heroImage),
                description: self.heroDescription,
                comics: self.heroComics,
                series: self.heroSeries,
                stories: self.heroStories
            )
        }
    }
    
}
