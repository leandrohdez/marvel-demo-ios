//
//  ComicTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class ComicTest: XCTestCase {
    
    private let comicTitle: String          = "Comic Title"
    private let comicImage: String          = "https://via.placeholder.com/80"
    
    var sut: Comic!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = Comic(id: 1, title: self.comicTitle, imageUrl: self.comicImage)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - Test Methods
extension ComicTest {
    
    //
    func testModelEquatablesValid() throws {
        // given
        let comic = Comic(id: 1, title: "Unknown", imageUrl: "https://via.placeholder.com/80")
        // then
        XCTAssertEqual(self.sut, comic, "The objects should be the equals")
    }
    
    //
    func testModelDataValid() throws {
        // then
        XCTAssertEqual(self.sut.id, 1, "Bad object initialization")
        XCTAssertEqual(self.sut.title, self.comicTitle, "Bad object initialization")
        XCTAssertEqual(self.sut.imageUrl, self.comicImage, "Bad object initialization")
    }
    
    //
    func testModelConvenienceDTOInitializationValid() throws {
        // given
        let jsonData = """
            {"id": 1, "title": "String", "thumbnail": {"path": "String", "extension": "String"}}
        """.data(using: .utf8)!
        
        // when
        do {
            let decoded = try JSONDecoder().decode(ComicResponse.self, from: jsonData)
            let comic = Comic(dto: decoded)
            
            // then
            XCTAssertEqual(self.sut, comic)
            
        } catch {
            XCTFail("Invalid serialization")
        }
    }
    
    //
    func testModelConvenienceDTOInitializationFail() throws {
        // given
        let jsonData = """
                {"id": 1, "thumbnail": {"path": "String", "extension": "String"}}
        """.data(using: .utf8)!
        
        // when
        do {
            let _ = try JSONDecoder().decode(ComicResponse.self, from: jsonData)
            XCTFail("Invalid JSON, should failed")
        } catch {
            // then
            XCTAssertTrue(true)
        }
    }
}

// MARK: - Performance Methods
extension ComicTest {

    //
    func testInitializationPerformance() {
        measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric()]) {
            self.sut = Comic(id: 1, title: self.comicTitle, imageUrl: self.comicImage)
        }
    }
    
}
