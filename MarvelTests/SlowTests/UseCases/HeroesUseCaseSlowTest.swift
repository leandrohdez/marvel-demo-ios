//
//  HeroesUseCaseSlowTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class HeroesUseCaseSlowTest: XCTestCase {
    
    var sut: HeroesUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = HeroesUseCase()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - Test Methods
extension HeroesUseCaseSlowTest {
    
    // Running Use Case (expected Success)
    func testFetchHeroesSuccess() throws {
        
        // when
        let promise = expectation(description: "Run Use Case")
        let input = HeroesUseCaseInput(pageIndex: 0, pageLength: 50)
        self.sut.execute(input: input, completion: { result in
            switch result {
                
            case .success(let output):
                // then
                XCTAssertEqual(output.heroes.count, 50, "The array should have 50 items")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Use Case returns error: \(error.localizedDescription)")
            }
        })
        
        wait(for: [promise], timeout: 5)
    }
    
    // Running Use Case (expected UnknownError)
    func testFetchHeroesError() throws {
        
        // when
        let promise = expectation(description: "Run Use Case")
        let input = HeroesUseCaseInput(pageIndex: -1, pageLength: -1)
        self.sut.execute(input: input) { result in
            
            // then
            switch result {
                
            case .success(_):
                return XCTFail("The use case should have failed")
                
            case .failure(_):
                promise.fulfill()
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
}
