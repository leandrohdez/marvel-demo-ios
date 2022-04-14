//
//  TopFiveUseCaseSlowTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class TopFiveUseCaseSlowTest: XCTestCase {
    
    var sut: TopFiveUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = TopFiveUseCase()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - Test Methods
extension TopFiveUseCaseSlowTest {
    
    // Running Use Case (expected Success)
    func testFetchTopFiveSuccess() throws {
        
        // when
        let promise = expectation(description: "Run Use Case")
        self.sut.execute { result in
            switch result {
                
            case .success(let output):
                XCTAssertEqual(output.heroes.count, 5, "The array should have 5 items")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Use Case returns error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
}
