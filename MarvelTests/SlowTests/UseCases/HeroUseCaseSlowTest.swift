//
//  HeroUseCaseSlowTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class HeroUseCaseSlowTest: XCTestCase {
    
    var sut: HeroUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = HeroUseCase()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }

}

// MARK: - Test Methods
extension HeroUseCaseSlowTest {
    
    // Running Use Case (expected Success)
    func testFetchHeroSuccess() throws {
        
        // given
        let characterCaptainAmerica = 1010913
        
        // when
        let promise = expectation(description: "Run Use Case")
        let input = HeroUseCaseInput(heroId: characterCaptainAmerica)
        self.sut.execute(input: input) { result in
            switch result {
                
            case .success(let output):
                // then
                XCTAssertEqual(output.hero.id, characterCaptainAmerica, "Invalid Hero returned")
                XCTAssertFalse(output.hero.comics.isEmpty, "Result should have comics")
                XCTAssertFalse(output.hero.series.isEmpty, "Result should have series")
                XCTAssertFalse(output.hero.stories.isEmpty, "Result should have stories")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Use Case returns error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
    // Running Use Case (expected NotFound)
    func testFetchHeroNotFound() throws {
        
        // given
        let characterNoExist = 1
        
        // when
        let promise = expectation(description: "Run Use Case")
        let input = HeroUseCaseInput(heroId: characterNoExist)
        self.sut.execute(input: input) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("The use case should have failed")
                
            case .failure(let error):
                // then
                if let apiError = error as? ApiMarvelError, apiError == ApiMarvelError.notFound {
                    promise.fulfill()
                } else {
                    return XCTFail("Use Case returns: unknownError")
                }
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
}
