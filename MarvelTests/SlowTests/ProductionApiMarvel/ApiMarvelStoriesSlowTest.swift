//
//  ApiMarvelStoriesSlowTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class ApiMarvelStoriesSlowTest: XCTestCase {
    
    var sut: ApiMarvel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = ApiMarvel.shared
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: -
extension ApiMarvelStoriesSlowTest {
    
    //
    func testCallServiceSuccess () throws {
        
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let promise = expectation(description: "Fetching Stories Success")
        
        // when
        self.sut.stories(requestData: requestData) { result in
            
            // then
            switch result {
                
            case .success(let responseData):
                
                XCTAssertTrue((responseData.count > 0), "")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    //
    func testCallServiceEmpty() throws {
        
        // given
        let characterNoExist = 1
        let requestData = CharacterRequest(id: characterNoExist)
        
        let promise = expectation(description: "Fetching Stories Empty")
        
        // when
        self.sut.stories(requestData: requestData) { result in
            
            // then
            switch result {
                
            case .success(let responseData):
                XCTAssertTrue(responseData.isEmpty, "")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
}
