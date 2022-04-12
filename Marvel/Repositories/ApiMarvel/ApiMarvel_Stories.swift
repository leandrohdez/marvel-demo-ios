//
//  ApiMarvel_Stories.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import Alamofire

extension ApiMarvel {
    
    /**
     Series
     
     Fetches series of comics about of character.

     How to use?
     =======================
     https://developer.marvel.com/docs#!/public/getCreatorCollection_get_5
     
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
    
    open func stories(requestData: CharacterRequest,
                      completion: @escaping (Result<[StoryResponse], Error>) -> Void) {
        
        let endpoint = ApiMarvelEndpoints.stories(requestData)
        
        self.httpClient.request(from: endpoint, of: StoryDataWrapperResponse.self) { response in
            
            switch response.result {
                
            case .success(let data):
                if data.status.uppercased() == "OK" {
                    completion(.success(data.data.results))
                    
                } else {
                    completion(.failure(ApiMarvelError.invalidData))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
