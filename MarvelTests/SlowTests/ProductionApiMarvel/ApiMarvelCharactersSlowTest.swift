//
//  ApiMarvelCharactersSlowTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class ApiMarvelCharactersSlowTest: XCTestCase {
    
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
extension ApiMarvelCharactersSlowTest {
    
    //
    func testCallServiceSuccess() throws {
        
        // given
        let requestData = PaginationRequest(offset: 0, limit: 10)
        
        let promise = expectation(description: "Fetching Characters Success")
        
        // when
        self.sut.characters(requestData: requestData) { result in
            
            // then
            switch result {
                
            case .success(let responseData):
                XCTAssertEqual(responseData.count, 10, "The array should have 10 items")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
}

