//
//  APIClient.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import Alamofire

class APIClient {
    
    static let shared = APIClient()
    
    @discardableResult
    func request(from route: URLRequestConvertible, completion: (@escaping (AFDataResponse<Data>) -> Void)) -> DataRequest {
        return AF.request(route)
            .validate(APIResponseValidator.validate)
            .responseData {
                completion($0)
            }
    }
    
    @discardableResult
    func request<T: Decodable>(from route: URLRequestConvertible, of type: T.Type, completion: (@escaping (DataResponse<T, AFError>) -> Void)) -> DataRequest {
        return AF.request(route)
            .validate(APIResponseValidator.validate)
            .log()
            .responseDecodable(of: T.self) { response in
                completion(response)
            }
    }
}
