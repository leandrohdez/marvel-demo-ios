//
//  ApiMarvelSeriesTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class ApiMarvelSeriesTest: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

}

// MARK: - Success Serialization
extension ApiMarvelSeriesTest {
    
    //
    func testServiceMockResponseValid() throws {
        
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 10, "total": 100, "count": 2, "results": [{"id": 1, "title": "String", "thumbnail": {"path": "String", "extension": "String"}}, {"id": 2, "title": "String", "thumbnail": {"path": "String", "extension": "String"}}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Series Success")
        apiMarvel.series(requestData: requestData) { result in
            
            switch result {
                
            case .success(let responseData):
                // then
                XCTAssertEqual(responseData.count, 2, "The array should have 2 items")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 1)
    }

    //
    func testServiceMockResponseEmptyValid() throws {
        
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Empty Series Success")
        apiMarvel.series(requestData: requestData) { result in
            
            switch result {
                
            case .success(let responseData):
                // then
                XCTAssertEqual(responseData.count, 0, "The array should have 0 items")
                promise.fulfill()
                
            case .failure(let error):
                return XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 1)
    }
}

// MARK: - Fail Serialization (Missing data)
extension ApiMarvelSeriesTest {
    
    // serialization fail - missing: serie id
    func testServiceMockResponseMissingSerieIdFail() throws {
        
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 10, "total": 100, "count": 1, "results": [{"title": "String", "thumbnail": {"path": "String", "extension": "String"}}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.series(requestData: requestData) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - missing: serie title
    func testServiceMockResponseMissingSerieTitleFail() throws {
        
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 10, "total": 100, "count": 1, "results": [{"id": 1, "thumbnail": {"path": "String", "extension": "String"}}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.series(requestData: requestData) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - missing: serie thumbnail
    func testServiceMockResponseMissingSerieThumbnailFail() throws {
        
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 10, "total": 100, "count": 1, "results": [{"id": 1, "title": "String", "thumbnail": {}}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.series(requestData: requestData) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - missing: serie thumbnail
    func testServiceMockResponseMissingSerieThumbnail02Fail() throws {
        
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 10, "total": 100, "count": 1, "results": [{"id": 1, "title": "String"}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.series(requestData: requestData) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("Invalid JSON, should failed")
                
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
extension ApiMarvelSeriesTest {
    
    // serialization fail - invalid type: serie id
    func testServiceMockResponseInvalidTypeSerieIdFail() throws {
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 10, "total": 100, "count": 1, "results": [{"id": "1", "title": "String", "thumbnail": {"path": "String", "extension": "String"}}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.series(requestData: requestData) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - invalid type: serie title
    func testServiceMockResponseInvalidTypeSerieTitleFail() throws {
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 10, "total": 100, "count": 1, "results": [{"id": 1, "title": true, "thumbnail": {"path": "String", "extension": "String"}}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.series(requestData: requestData) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - invalid type: serie thumbnail
    func testServiceMockResponseInvalidTypeSerieThumbnailFail() throws {
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 10, "total": 100, "count": 1, "results": [{"id": 1, "title": "String", "thumbnail": [{"path": "String", "extension": "String"}]}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.series(requestData: requestData) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - invalid type: serie thumbnail
    func testServiceMockResponseInvalidTypeSerieThumbnail02Fail() throws {
        // given
        let characterCaptainAmerica = 1010913
        let requestData = CharacterRequest(id: characterCaptainAmerica)
        
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 10, "total": 100, "count": 1, "results": [{"id": 1, "title": "String", "thumbnail": {"path": 99, "extension": "String"}}]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.series(requestData: requestData) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("Invalid JSON, should failed")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
}
