//
//  ApiMarvelCharacterTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class ApiMarvelCharacterTest: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

}

// MARK: - Success Serialization
extension ApiMarvelCharacterTest {
    
    //
    func testServiceMockResponseValid() throws {
        
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 1, "count": 1, "results": [{"id": 1010913, "name": "String", "description": "String", "thumbnail": {"path": "String", "extension": "String"}, "urls": []}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Character Success")
        apiMarvel.character(requestData: requestData) { result in
            
            switch result {
                
            case .success(let responseData):
                // then
                XCTAssertEqual(responseData.id, characterCaptainAmerica, "The id should be the equals")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 1)
    }
}

// MARK: - Expected Errors
extension ApiMarvelCharacterTest {
    
    //
    func testServiceMockResponseNotFoundError() throws {
        
        // given
        let characterNoExist = 1
        let requestData = CharacterRequest(id: characterNoExist)
        
        let jsonData = """
            {"code": 404, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 0, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Not Found")
        apiMarvel.character(requestData: requestData) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("The service should have response: ApiMarvelError.notFound")
                
            case .failure(let error):
                XCTAssertEqual(error as? ApiMarvelError, ApiMarvelError.notFound,
                               "For a not founded character the service should return ApiMarvelError.notFound")
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
}

// MARK: - Fail Serialization (Missing data)
extension ApiMarvelCharacterTest {
    
    // serialization fail - missing: character id
    func testServiceMockResponseMissingCharacterIdFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 1, "count": 1, "results": [{"name": "String", "description": "String", "thumbnail": {"path": "String", "extension": "String"}, "urls": []}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
            switch result {
                
            case .success(_):
                XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - missing: character name
    func testServiceMockResponseMissingCharacterNameFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 1, "count": 1, "results": [{"id": 1, "description": "String", "thumbnail": {"path": "String", "extension": "String"}, "urls": []}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
            switch result {
                
            case .success(_):
                XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - missing: character description
    func testServiceMockResponseMissingCharacterDescriptionFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 1, "count": 1, "results": [{"id": 1, "name": "String", "thumbnail": {"path": "String", "extension": "String"}, "urls": []}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
            switch result {
                
            case .success(_):
                XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - missing: thumbnail object
    func testServiceMockResponseMissingThumbnailObjectFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 1, "count": 1, "results": [{"id": 1, "name": "String", "description": "String", "urls": []}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
            switch result {
                
            case .success(_):
                XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - missing: url array
    func testServiceMockResponseMissingUrlsArrayFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 1, "count": 1, "results": [{"id": 1, "name": "String", "description": "String", "thumbnail": {"path": "String", "extension": "String"}}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
            switch result {
                
            case .success(_):
                XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
}

// MARK: - Fail Serialization (Invalid type)
extension ApiMarvelCharacterTest {
    
    // serialization fail - invalid type: character id
    func testServiceMockResponseInvalidTypeCharacterIdFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 1, "count": 1, "results": [{"id": "1", "name": "String", "description": "String", "thumbnail": {"path": "String", "extension": "String"}, "urls": []}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
            switch result {
                
            case .success(_):
                XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - invalid type: character urls
    func testServiceMockResponseInvalidTypeCharacterUrlsFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 1, "count": 1, "results": [{"id": 1, "name": "String", "description": "String", "thumbnail": {"path": "String", "extension": "String"}, "urls": {}}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
            switch result {
                
            case .success(_):
                XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - invalid type: character urls
    func testServiceMockResponseInvalidTypeCharacterUrls02Fail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 1, "count": 1, "results": [{"id": 1, "name": "String", "description": "String", "thumbnail": {"path": "String", "extension": "String"}, "urls": "String"}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
            switch result {
                
            case .success(_):
                XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
}
