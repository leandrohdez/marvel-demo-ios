//
//  APILogger.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import Alamofire

extension DataRequest {

    public func log() -> Self {
        
        #if DEBUG
        
        let urlString = self.convertible.urlRequest?.url?.absoluteString ?? "?"
        let method = self.convertible.urlRequest?.httpMethod ?? "?"
        print("REQUEST: \(Date()) [\(method)] \(urlString)")

        return self.responseJSON(completionHandler: {$0.log()})
            
        #endif
    }

}

fileprivate extension DataResponse {

    func log() {
        #if DEBUG

        switch self.result {
            
        case .success(let successData):
            print("🟢 RESPONSE: \(Date()) [DONE] \(self.request?.url?.absoluteString ?? "nil") \(successData)")
        case .failure(let error):
            print("🔴 RESPONSE: \(Date()) \(self.request?.url?.absoluteString ?? "nil") \(error)")
        }
        #endif
    }
}
