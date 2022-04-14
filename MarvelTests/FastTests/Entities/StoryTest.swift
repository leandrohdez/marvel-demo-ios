//
//  StoryTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class StoryTest: XCTestCase {
    
    private let storyTitle: String          = "Story Title"
    private let storyImage: String          = "https://via.placeholder.com/80"
    
    var sut: Story!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = Story(id: 1, title: self.storyTitle, imageUrl: self.storyImage)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - Test Methods
extension StoryTest {
    
    //
    func testModelEquatablesValid() throws {
        // given
        let story = Story(id: 1, title: "Unknown", imageUrl: "https://via.placeholder.com/80")
        // then
        XCTAssertEqual(self.sut, story, "The objects should be the equals")
    }
    
    //
    func testModelDataValid() throws {
        // then
        XCTAssertEqual(self.sut.id, 1, "Bad object initialization")
        XCTAssertEqual(self.sut.title, self.storyTitle, "Bad object initialization")
        XCTAssertEqual(self.sut.imageUrl, self.storyImage, "Bad object initialization")
    }
    
    //
    func testModelConvenienceDTOInitializationValid() throws {
        // given
        let jsonData = """
            {"id": 1, "title": "String", "thumbnail": {"path": "String", "extension": "String"}}
        """.data(using: .utf8)!
        
        // when
        do {
            let decoded = try JSONDecoder().decode(StoryResponse.self, from: jsonData)
            let story = Story(dto: decoded)
            
            // then
            XCTAssertEqual(self.sut, story)
            
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
            let _ = try JSONDecoder().decode(StoryResponse.self, from: jsonData)
            XCTFail("Invalid JSON, should failed")
        } catch {
            // then
            XCTAssertTrue(true)
        }
    }
}

// MARK: - Performance Methods
extension StoryTest {

    //
    func testInitializationPerformance() {
        measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTStorageMetric(), XCTMemoryMetric()]) {
            self.sut = Story(id: 1, title: self.storyTitle, imageUrl: self.storyImage)
        }
    }
    
}
