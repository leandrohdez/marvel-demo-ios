//
//  TopFiveUseCaseTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class TopFiveUseCaseTest: XCTestCase {

    // Use case properties
    private let characterAbomination: Int       = 1009146
    private let characterCaptainAmerica: Int    = 1010913
    private let characterBlackBolt: Int         = 1009184
    private let characterBlackPhanter: Int      = 1011130
    private let characterCaliban: Int           = 1009216
    
    var sut: TopFiveUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }
}

// MARK: - Execution
extension TopFiveUseCaseTest {
    
    //
    func testUseCaseExecutionValid() throws {
        
        // given
        class MockApiMarvel: MockApiMarvelRepository {
            
            func character(requestData: CharacterRequest, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
                let mockResponse = CharacterResponse(
                    id: requestData.characterId,
                    name: "Superhero",
                    description: "Superhero description",
                    thumbnail: ThumbnailResponse(path: "image", ext: "png"),
                    urls: [CharacterURLResponse(type: "mock", url: "http://test-url.mock")]
                )
                completion(Result<CharacterResponse, Error>.success(mockResponse))
            }
        }
        
        self.sut = TopFiveUseCase(dependencies: TopFiveUseCase.Dependency(apiMarvelRepository: MockApiMarvel()))
        
        // when
        let promise = expectation(description: "Run Use Case Success")
        self.sut.execute { result in
            switch result {
                
            case .success(let output):
                // then
                XCTAssertEqual(output.heroes.count, 5, "The array should have 5 items")
                XCTAssertEqual(output.heroes[0].id, self.characterAbomination, "The parameters should be equals")
                XCTAssertEqual(output.heroes[1].id, self.characterCaptainAmerica, "The parameters should be equals")
                XCTAssertEqual(output.heroes[2].id, self.characterBlackBolt, "The parameters should be equals")
                XCTAssertEqual(output.heroes[3].id, self.characterBlackPhanter, "The parameters should be equals")
                XCTAssertEqual(output.heroes[4].id, self.characterCaliban, "The parameters should be equals")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 0.1)
    }
    
    // with error service
    func testUseCaseExecutionEmptyValid() throws {
        
        // given
        class MockApiMarvel: MockApiMarvelRepository {
            
            func character(requestData: CharacterRequest, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
                completion(Result<CharacterResponse, Error>.failure(ApiMarvelError.invalidData))
            }
        }
        
        self.sut = TopFiveUseCase(dependencies: TopFiveUseCase.Dependency(apiMarvelRepository: MockApiMarvel()))
        
        // when
        let promise = expectation(description: "Run Use Case Success")
        self.sut.execute { result in
            switch result {
                
            case .success(let output):
                // then
                XCTAssertTrue(output.heroes.isEmpty, "The array must be empty")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 0.1)
    }
    
}
