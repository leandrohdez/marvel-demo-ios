//
//  HeroesUseCaseTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class HeroesUseCaseTest: XCTestCase {

    var sut: HeroesUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }
}

// MARK: - Execution
extension HeroesUseCaseTest {
    
    //
    func testUseCaseExecutionValid() throws {
        
        // given
        class MockApiMarvel: MockApiMarvelRepository {
            // mocked service
            func characters(requestData: PaginationRequest, completion: @escaping (Result<[CharacterResponse], Error>) -> Void) {
                let thumbnail = ThumbnailResponse(path: "path", ext: "ext")
                var mockResponse = [CharacterResponse]()
                mockResponse.append(CharacterResponse(id: 1, name: "Character", description: "Description", thumbnail: thumbnail, urls: []))
                mockResponse.append(CharacterResponse(id: 2, name: "Character", description: "Description", thumbnail: thumbnail, urls: []))
                mockResponse.append(CharacterResponse(id: 3, name: "Character", description: "Description", thumbnail: thumbnail, urls: []))
                mockResponse.append(CharacterResponse(id: 4, name: "Character", description: "Description", thumbnail: thumbnail, urls: []))
                mockResponse.append(CharacterResponse(id: 5, name: "Character", description: "Description", thumbnail: thumbnail, urls: []))
                completion(Result<[CharacterResponse], Error>.success(mockResponse))
            }
        }
        
        self.sut = HeroesUseCase(dependencies: HeroesUseCase.Dependency(apiMarvelRepository: MockApiMarvel()))
        
        // when
        let promise = expectation(description: "Run Use Case Success")
        self.sut.execute(input: HeroesUseCaseInput(pageIndex: 0, pageLength: 50)) { result in
            switch result {
                
            case .success(let output):
                // then
                XCTAssertEqual(output.heroes.count, 5, "The array should have 5 items")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 0.1)
    }

    //
    func testUseCaseExecutionEmptyValid() throws {
        
        // given
        class MockApiMarvel: MockApiMarvelRepository {
            // mocked service
            func characters(requestData: PaginationRequest, completion: @escaping (Result<[CharacterResponse], Error>) -> Void) {
                let mockResponse = [CharacterResponse]()
                completion(Result<[CharacterResponse], Error>.success(mockResponse))
            }
        }
        
        self.sut = HeroesUseCase(dependencies: HeroesUseCase.Dependency(apiMarvelRepository: MockApiMarvel()))
        
        // when
        let promise = expectation(description: "Run Use Case Success")
        self.sut.execute(input: HeroesUseCaseInput(pageIndex: 0, pageLength: 50)) { result in
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
    
    //
    func testUseCaseExecutionFail() throws {
        
        // given
        class MockApiMarvel: MockApiMarvelRepository {
            // mocked service
            func characters(requestData: PaginationRequest, completion: @escaping (Result<[CharacterResponse], Error>) -> Void) {
                completion(Result<[CharacterResponse], Error>.failure(ApiMarvelError.invalidData))
            }
        }
        
        self.sut = HeroesUseCase(dependencies: HeroesUseCase.Dependency(apiMarvelRepository: MockApiMarvel()))
        
        // when
        let promise = expectation(description: "Run Use Case Fail")
        self.sut.execute(input: HeroesUseCaseInput(pageIndex: 0, pageLength: 50)) { result in
            switch result {
                
            case .success(_):
                return XCTFail("Not expected result")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 0.1)
    }
}
