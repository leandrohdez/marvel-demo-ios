//
//  ApiMarvel_Character.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import Alamofire

extension ApiMarvel {
    
    /**
     Character
     
     Detail of comic character.

     How to use?
     =======================
     https://developer.marvel.com/docs#!/public/getCreatorCollection_get_1
     
     Important!
     =======================
     ...
     
     - version: 1.0
        
     - parameter requestData:       Parameters required to launch the request
     - parameter completion:        Completion closure returned as the asynchronous result of the call
     - parameter responseData:      DTO object returned from the api
     - parameter error:             Error object
     
     - throws: `Error?`
     
     - returns: `Void`

     */
    
    open func character(requestData: CharacterRequest,
                        completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        
        let endpoint = ApiMarvelEndpoints.character(requestData)
        
        self.httpClient.request(from: endpoint, of: CharacterDataWrapperResponse.self) { response in
            
            switch response.result {
                
            case .success(let data):
                if data.status.uppercased() == "OK" {
                    
                    if let characterResponse = data.data.results.first {
                        completion(.success(characterResponse))
                    } else {
                        completion(.failure(ApiMarvelError.notFound))
                    }
                    
                } else {
                    completion(.failure(ApiMarvelError.invalidData))
                }
                
            case .failure(let error):
                if error.responseCode == 404 {
                    completion(.failure(ApiMarvelError.notFound))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
