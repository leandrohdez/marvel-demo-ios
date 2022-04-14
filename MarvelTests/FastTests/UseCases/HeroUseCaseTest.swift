//
//  HeroUseCaseTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import XCTest
@testable import Marvel

class HeroUseCaseTest: XCTestCase {

    private let heroName: String            = "Superhero"
    private let heroDescription: String     = "Superhero description"
    private let heroImage: String           = "image.png"
    private let heroUrls: [String]          = ["http://test-url.mock"]
    
    var sut: HeroUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        try super.tearDownWithError()
    }
}

// MARK: - Execution
extension HeroUseCaseTest {
    
    //
    func testUseCaseExecutionValid() throws {
        
        // given
        class MockApiMarvel: MockApiMarvelRepository {
            
            func character(requestData: CharacterRequest, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
                let mockResponse = CharacterResponse(
                    id: 1,
                    name: "Superhero",
                    description: "Superhero description",
                    thumbnail: ThumbnailResponse(path: "image", ext: "png"),
                    urls: [CharacterURLResponse(type: "mock", url: "http://test-url.mock")]
                )
                completion(Result<CharacterResponse, Error>.success(mockResponse))
            }
            
            func comics(requestData: CharacterRequest, completion: @escaping (Result<[ComicResponse], Error>) -> Void) {
                completion(Result<[ComicResponse], Error>.success([]))
            }
            
            func series(requestData: CharacterRequest, completion: @escaping (Result<[SerieResponse], Error>) -> Void) {
                completion(Result<[SerieResponse], Error>.success([]))
            }
            
            func stories(requestData: CharacterRequest, completion: @escaping (Result<[StoryResponse], Error>) -> Void) {
                completion(Result<[StoryResponse], Error>.success([]))
            }
        }
        
        self.sut = HeroUseCase(dependencies: HeroUseCase.Dependency(apiMarvelRepository: MockApiMarvel()))
        
        // when
        let promise = expectation(description: "Run Use Case Success")
        self.sut.execute(input: HeroUseCaseInput(heroId: 1)) { result in
            switch result {
                
            case .success(let output):
                // then
                XCTAssertEqual(output.hero.id, 1, "The parameters should be equals")
                XCTAssertEqual(output.hero.name, self.heroName, "The parameters should be equals")
                XCTAssertEqual(output.hero.description, self.heroDescription, "The parameters should be equals")
                XCTAssertEqual(output.hero.imageUrl, self.heroImage, "The parameters should be equals")
                XCTAssertEqual(output.hero.urls, self.heroUrls, "The parameters should be equals")
                XCTAssertTrue(output.hero.comics.isEmpty, "The array must be empty")
                XCTAssertTrue(output.hero.series.isEmpty, "The array must be empty")
                XCTAssertTrue(output.hero.stories.isEmpty, "The array must be empty")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 0.1)
    }
    
    //
    func testUseCaseExecution02Valid() throws {
        
        // given
        class MockApiMarvel: MockApiMarvelRepository {
            
            func character(requestData: CharacterRequest, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
                let mockResponse = CharacterResponse(
                    id: 1,
                    name: "Superhero",
                    description: "Superhero description",
                    thumbnail: ThumbnailResponse(path: "image", ext: "png"),
                    urls: [CharacterURLResponse(type: "mock", url: "http://test-url.mock")]
                )
                completion(Result<CharacterResponse, Error>.success(mockResponse))
            }
            
            func comics(requestData: CharacterRequest, completion: @escaping (Result<[ComicResponse], Error>) -> Void) {
                let mockResponse = ComicResponse(id: 1, title: "Title", thumbnail: ThumbnailResponse(path: "image", ext: "png"))
                completion(Result<[ComicResponse], Error>.success([mockResponse]))
            }
            
            func series(requestData: CharacterRequest, completion: @escaping (Result<[SerieResponse], Error>) -> Void) {
                let mockResponse = SerieResponse(id: 1, title: "Title", thumbnail: ThumbnailResponse(path: "image", ext: "png"))
                completion(Result<[SerieResponse], Error>.success([mockResponse]))
            }
            
            func stories(requestData: CharacterRequest, completion: @escaping (Result<[StoryResponse], Error>) -> Void) {
                completion(Result<[StoryResponse], Error>.success([]))
            }
        }
        
        self.sut = HeroUseCase(dependencies: HeroUseCase.Dependency(apiMarvelRepository: MockApiMarvel()))
        
        // when
        let promise = expectation(description: "Run Use Case Success")
        self.sut.execute(input: HeroUseCaseInput(heroId: 1)) { result in
            switch result {
                
            case .success(let output):
                // then
                XCTAssertEqual(output.hero.id, 1, "The parameters should be equals")
                XCTAssertEqual(output.hero.name, self.heroName, "The parameters should be equals")
                XCTAssertEqual(output.hero.description, self.heroDescription, "The parameters should be equals")
                XCTAssertEqual(output.hero.imageUrl, self.heroImage, "The parameters should be equals")
                XCTAssertEqual(output.hero.urls, self.heroUrls, "The parameters should be equals")
                XCTAssertFalse(output.hero.comics.isEmpty, "The array must not be empty")
                XCTAssertFalse(output.hero.series.isEmpty, "The array must not be empty")
                XCTAssertTrue(output.hero.stories.isEmpty, "The array must be empty")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 0.1)
    }
    
    // with empty default comics
    func testUseCaseExecutionEmptyDefaultComicsValid() throws {
        
        // given
        class MockApiMarvel: MockApiMarvelRepository {
            
            func character(requestData: CharacterRequest, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
                let mockResponse = CharacterResponse(
                    id: 1,
                    name: "Superhero",
                    description: "Superhero description",
                    thumbnail: ThumbnailResponse(path: "image", ext: "png"),
                    urls: [CharacterURLResponse(type: "mock", url: "http://test-url.mock")]
                )
                completion(Result<CharacterResponse, Error>.success(mockResponse))
            }
            
            func comics(requestData: CharacterRequest, completion: @escaping (Result<[ComicResponse], Error>) -> Void) {
                completion(Result<[ComicResponse], Error>.failure(ApiMarvelError.invalidData))
            }
            
            func series(requestData: CharacterRequest, completion: @escaping (Result<[SerieResponse], Error>) -> Void) {
                let mockResponse = SerieResponse(id: 1, title: "Title", thumbnail: ThumbnailResponse(path: "image", ext: "png"))
                completion(Result<[SerieResponse], Error>.success([mockResponse]))
            }
            
            func stories(requestData: CharacterRequest, completion: @escaping (Result<[StoryResponse], Error>) -> Void) {
                completion(Result<[StoryResponse], Error>.success([]))
            }
        }
        
        self.sut = HeroUseCase(dependencies: HeroUseCase.Dependency(apiMarvelRepository: MockApiMarvel()))
        
        // when
        let promise = expectation(description: "Run Use Case Success")
        self.sut.execute(input: HeroUseCaseInput(heroId: 1)) { result in
            switch result {
                
            case .success(let output):
                // then
                XCTAssertEqual(output.hero.id, 1, "The parameters should be equals")
                XCTAssertEqual(output.hero.name, self.heroName, "The parameters should be equals")
                XCTAssertEqual(output.hero.description, self.heroDescription, "The parameters should be equals")
                XCTAssertEqual(output.hero.imageUrl, self.heroImage, "The parameters should be equals")
                XCTAssertEqual(output.hero.urls, self.heroUrls, "The parameters should be equals")
                XCTAssertTrue(output.hero.comics.isEmpty, "The array must be empty")
                XCTAssertFalse(output.hero.series.isEmpty, "The array must not be empty")
                XCTAssertTrue(output.hero.stories.isEmpty, "The array must be empty")
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
            
            func character(requestData: CharacterRequest, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
                completion(Result<CharacterResponse, Error>.failure(ApiMarvelError.invalidData))
            }
            
            func comics(requestData: CharacterRequest, completion: @escaping (Result<[ComicResponse], Error>) -> Void) {
                completion(Result<[ComicResponse], Error>.success([]))
            }
            
            func series(requestData: CharacterRequest, completion: @escaping (Result<[SerieResponse], Error>) -> Void) {
                completion(Result<[SerieResponse], Error>.success([]))
            }
            
            func stories(requestData: CharacterRequest, completion: @escaping (Result<[StoryResponse], Error>) -> Void) {
                completion(Result<[StoryResponse], Error>.success([]))
            }
        }
        
        self.sut = HeroUseCase(dependencies: HeroUseCase.Dependency(apiMarvelRepository: MockApiMarvel()))
        
        // when
        let promise = expectation(description: "Run Use Case Fail")
        self.sut.execute(input: HeroUseCaseInput(heroId: 1)) { result in
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
