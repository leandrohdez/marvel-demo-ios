//
//  HttpClient.swift
//  Marvel
//
//  Created by Leandro Hernandez on 12/4/22.
//

import Foundation
import Alamofire

class HttpClient {
    
    var session: Session
    
    init(session: Session = AF) {
        self.session = session
    }
    
    @discardableResult
    func request(from route: URLRequestConvertible, completion: (@escaping (AFDataResponse<Data>) -> Void)) -> DataRequest {
        return self.session.request(route)
            .validate(APIResponseValidator.validate)
            .responseData {
                completion($0)
            }
    }
    
    @discardableResult
    func request<T: Decodable>(from route: URLRequestConvertible, of type: T.Type, completion: (@escaping (DataResponse<T, AFError>) -> Void)) -> DataRequest {
        return self.session.request(route)
            .validate(APIResponseValidator.validate)
            .log()
            .responseDecodable(of: T.self) { response in
                completion(response)
            }
    }
    
}
