//
//  APIResponseValidator.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import Alamofire

struct APIResponseValidator {
    
    fileprivate static func validateData(req: URLRequest?, resp: HTTPURLResponse, data: Data?) -> DataRequest.ValidationResult {
        
        let statusCodeIsValid = (200...300).contains(resp.statusCode)

        print("---------------------------------------")
        print("  HTTP-STATUS-CODE: \(resp.statusCode) \(statusCodeIsValid ? "(VALID)" : "(INVALID)")")
        print("---------------------------------------")
        // responder si el el codigo es de error lo devuelve
        if !statusCodeIsValid {
            return .failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: resp.statusCode)))
            
        } else {
            return .success(())
        }
    }
    
    static func validate(_ req: URLRequest?, _ resp: HTTPURLResponse, _ data: Data?) -> DataRequest.ValidationResult {
        return validateData(req: req, resp: resp, data: data)
    }
    
}

fileprivate extension Data {
    
    func asDictionary() -> [String: Any]? {
        guard let JSON = try? JSONSerialization.jsonObject(with: self, options: .allowFragments),
            let dict = JSON as? [String: Any] else {
                return nil
        }
        return dict
    }
}
