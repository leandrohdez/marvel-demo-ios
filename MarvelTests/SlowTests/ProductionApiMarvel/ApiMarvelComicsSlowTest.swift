//
//  ApiMarvelComicsSlowTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class ApiMarvelComicsSlowTest: XCTestCase {
    
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
extension ApiMarvelComicsSlowTest {
    
    //
    func testCallServiceSuccess () throws {
        
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let promise = expectation(description: "Fetching Comics Success")
        
        // when
        self.sut.comics(requestData: requestData) { result in
            
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
        
        let promise = expectation(description: "Fetching Comics Empty")
        
        // when
        self.sut.comics(requestData: requestData) { result in
            
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
