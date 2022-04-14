//
//  ApiMarvelCharacterSlowTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest

@testable import Marvel

class ApiMarvelCharacterSlowTest: XCTestCase {
    
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
extension ApiMarvelCharacterSlowTest {
    
    //
    func testCallServiceSuccess() throws {
        
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let promise = expectation(description: "Fetching Character Success")
        
        // when
        self.sut.character(requestData: requestData) { result in
            
            // then
            switch result {
                
            case .success(let responseData):
                XCTAssertEqual(responseData.id, 1010913, "The array should have 1 item")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    //
    func testApiMarvelCharacterNotFound() throws {
        
        // given
        let characterNoExist = 1
        let requestData = CharacterRequest(id: characterNoExist)
        
        let promise = expectation(description: "Fetching Character Fail")
        
        // when
        self.sut.character(requestData: requestData) { result in
            
            // then
            switch result {
                
            case .success(_):
                return XCTFail("The service should have response: ApiMarvelError.notFound")
                
            case .failure(let error):
                XCTAssertEqual(error as? ApiMarvelError, ApiMarvelError.notFound,
                               "For a not founded character the service should return ApiMarvelError.notFound")
                promise.fulfill()
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
}
