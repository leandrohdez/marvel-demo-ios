//
//  MockHttpClient.swift
//  Marvel
//
//  Created by Leandro Hernandez on 12/4/22.
//

import Foundation
import Alamofire

class MockHttpClient: HttpClient {
    
    private let responseMockData: Data
    
    init(responseMockData: Data) {
        self.responseMockData = responseMockData
    }
    
    //
    override func request<T: Decodable>(from route: URLRequestConvertible, of type: T.Type, completion: (@escaping (DataResponse<T, AFError>) -> Void)) -> DataRequest {
        return AF.request(MockEndpoint.mock)
            .responseDecodable(of: T.self) { response in
    
            do {
                let decoded = try JSONDecoder().decode(T.self, from: self.responseMockData)
                
                let result = Result<T, AFError>.success(decoded)
                
                let fakeResponseData = DataResponse(
                    request: route.urlRequest,
                    response: HTTPURLResponse(url: route.urlRequest!.url!, statusCode: 200, httpVersion: nil, headerFields: nil),
                    data: Data(),
                    metrics: nil,
                    serializationDuration: Date().timeIntervalSinceNow,
                    result: result
                )
                
                completion(fakeResponseData)
                
            } catch let e {
                
                let result = Result<T, AFError>.failure(AFError.responseSerializationFailed(reason: .decodingFailed(error: e)))
                
                let errorResponseData = DataResponse(
                    request: route.urlRequest,
                    response: HTTPURLResponse(url: route.urlRequest!.url!, statusCode: 500, httpVersion: nil, headerFields: nil),
                    data: Data(),
                    metrics: nil,
                    serializationDuration: Date().timeIntervalSinceNow,
                    result: result
                )
                
                completion(errorResponseData)
            }
        }
    }
    
}

fileprivate enum MockEndpoint: URLRequestConvertible {
    
    case mock
    
    var path: String {
        switch self {
        case .mock:         return "/mock"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .mock:         return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .mock:         return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try "http://api.mock".asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .mock:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
    
}
