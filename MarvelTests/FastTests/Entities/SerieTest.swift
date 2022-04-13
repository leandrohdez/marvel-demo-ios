//
//  SerieTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class SerieTest: XCTestCase {
    
    private let serieTitle: String          = "Serie Title"
    private let serieImage: String          = "https://via.placeholder.com/80"
    
    var sut: Serie!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = Serie(id: 1, title: self.serieTitle, imageUrl: self.serieImage)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - Test Methods
extension SerieTest {
    
    //
    func testModelEquatablesValid() throws {
        // given
        let serie = Serie(id: 1, title: "Unknown", imageUrl: "https://via.placeholder.com/80")
        // then
        XCTAssertEqual(self.sut, serie, "The objects should be the equals")
    }
    
    //
    func testModelDataValid() throws {
        // then
        XCTAssertEqual(self.sut.id, 1, "Bad object initialization")
        XCTAssertEqual(self.sut.title, self.serieTitle, "Bad object initialization")
        XCTAssertEqual(self.sut.imageUrl, self.serieImage, "Bad object initialization")
    }
    
    //
    func testModelConvenienceDTOInitializationValid() throws {
        // given
        let jsonData = """
            {"id": 1, "title": "String", "thumbnail": {"path": "String", "extension": "String"}}
        """.data(using: .utf8)!
        
        // when
        do {
            let decoded = try JSONDecoder().decode(SerieResponse.self, from: jsonData)
            let serie = Serie(dto: decoded)
            
            // then
            XCTAssertEqual(self.sut, serie)
            
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
            let _ = try JSONDecoder().decode(SerieResponse.self, from: jsonData)
            XCTFail("Invalid JSON, should failed")
        } catch {
            // then
            XCTAssertTrue(true)
        }
    }
}

// MARK: - Performance Methods
extension SerieTest {

    //
    func testInitializationPerformance() {
        measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric()]) {
            self.sut = Serie(id: 1, title: self.serieTitle, imageUrl: self.serieImage)
        }
    }
    
}
