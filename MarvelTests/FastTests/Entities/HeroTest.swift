//
//  HeroTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class HeroTest: XCTestCase {
    
    private let heroName: String            = "Superhero"
    private let heroDescription: String     = "Superhero description"
    private let heroImage: String           = "https://via.placeholder.com/80"
    private let heroUrls: [String]          = ["Test String"]
    
    var sut: Hero!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = Hero(id: 1, name: self.heroName, description: self.heroDescription, imageUrl: self.heroImage, urls: self.heroUrls)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - Test Methods
extension HeroTest {
    
    //
    func testModelEquatablesValid() throws {
        // given
        let hero = Hero(id: 1, name: "Unknown", description: "Unknown", imageUrl: "https://via.placeholder.com/80")
        // then
        XCTAssertEqual(self.sut, hero, "The objects should be the equals")
    }
    
    //
    func testModelDataValid() throws {
        // then
        XCTAssertEqual(self.sut.id, 1, "Bad object initialization")
        XCTAssertEqual(self.sut.name, self.heroName, "Bad object initialization")
        XCTAssertEqual(self.sut.description, self.heroDescription, "Bad object initialization")
        XCTAssertEqual(self.sut.imageUrl, self.heroImage, "Bad object initialization")
        XCTAssertEqual(self.sut.urls.count, self.heroUrls.count, "Bad object initialization")
    }
    
    //
    func testModelConvenienceDTOInitializationValid() throws {
        // given
        let jsonData = """
            {"id": 1, "name": "String", "description": "String", "thumbnail": {"path": "String", "extension": "String"}, "urls": []}
        """.data(using: .utf8)!
        
        // when
        do {
            let decoded = try JSONDecoder().decode(CharacterResponse.self, from: jsonData)
            let hero = Hero(dto: decoded)
            
            // then
            XCTAssertEqual(self.sut, hero)
            
        } catch {
            XCTFail("Invalid serialization")
        }
    }
    
    //
    func testModelConvenienceDTOInitializationFail() throws {
        // given
        let jsonData = """
            {"id": 1, "name": "String", "description": "String", "thumbnail": {"path": "String", "extension": "String"}}
        """.data(using: .utf8)!
        
        // when
        do {
            let _ = try JSONDecoder().decode(CharacterResponse.self, from: jsonData)
            XCTFail("Invalid JSON, should failed")
        } catch {
            // then
            XCTAssertTrue(true)
        }
    }
    
}

// MARK: - Performance Methods
extension HeroTest {

    //
    func testInitializationPerformance() {
        measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric()]) {
            self.sut = Hero(id: 1, name: self.heroName, description: self.heroDescription, imageUrl: self.heroImage, urls: self.heroUrls)
        }
    }
    
}
