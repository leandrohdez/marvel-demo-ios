//
//  ApiMarvelGenericResponseTest.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 12/4/22.
//

import XCTest
@testable import Marvel

class ApiMarvelGenericResponseTest: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

}

extension ApiMarvelGenericResponseTest {
    
    //
    func testServiceMockResponseSuccessValid() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Status Success")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
extension ApiMarvelGenericResponseTest {
    
    // serialization fail - missing: code
    func testServiceMockResponseMissingCodeFail() throws {
        
        // given
        let jsonData = """
            {"status": "OK", "data": {"offset": 0, "limit": 1, "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - missing: status
    func testServiceMockResponseMissingStatusFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "data": {"offset": 0, "limit": 1, "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - missing: data
    func testServiceMockResponseMissingDataFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK"}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - missing: offset
    func testServiceMockResponseMissingOffsetFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"limit": 1, "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - missing: limit
    func testServiceMockResponseMissingLimitFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - missing: total
    func testServiceMockResponseMissingTotalFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - missing: count
    func testServiceMockResponseMissingCountFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 100, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - missing: results
    func testServiceMockResponseMissingResultsFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 100, "count": 0}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
extension ApiMarvelGenericResponseTest {
    
    // serialization fail - invalid type: code
    func testServiceMockResponseInvalidTypeCodeFail() throws {
        
        // given
        let jsonData = """
            {"code": "200", "status": "OK", "data": {"offset": 0, "limit": 1, "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - invalid type: status
    func testServiceMockResponseInvalidTypeStatusFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": true, "data": {"offset": 0, "limit": 1, "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Serialization Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - invalid type: status
    func testServiceMockResponseInvalidTypeStatus02Fail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "very well", "data": {"offset": 0, "limit": 1, "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Status Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
            switch result {
                
            case .success(_):
                return XCTFail("Not expected Status string")
                
            case .failure(_):
                // then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    // serialization fail - invalid type: data
    func testServiceMockResponseInvalidTypeDataFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": [{"offset": 0, "limit": 1, "total": 100, "count": 0, "results": []}]}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Status Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - invalid type: offset
    func testServiceMockResponseInvalidTypeOffsetFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": false, "limit": 1, "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Status Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - invalid type: limit
    func testServiceMockResponseInvalidTypeLimitFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": "1", "total": 100, "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Status Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - invalid type: total
    func testServiceMockResponseInvalidTypeTotalFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": "hundred", "count": 0, "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Status Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - invalid type: count
    func testServiceMockResponseInvalidTypeCountFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 100, "count": "0", "results": []}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Status Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - invalid type: results
    func testServiceMockResponseInvalidTypeResultsFail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 100, "count": 0, "results": {}}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Status Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
    
    // serialization fail - invalid type: results
    func testServiceMockResponseInvalidTypeResults02Fail() throws {
        
        // given
        let jsonData = """
            {"code": 200, "status": "OK", "data": {"offset": 0, "limit": 1, "total": 100, "count": 0, "results": ["item"]}}
        """.data(using: .utf8)!
        
        let apiMarvel = ApiMarvel(client: MockHttpClient(responseMockData: jsonData))
        
        // when
        let promise = expectation(description: "Fetching Status Fail")
        apiMarvel.characters(requestData: PaginationRequest(offset: 0, limit: 1)) { result in
            
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
