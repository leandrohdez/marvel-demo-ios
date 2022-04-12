//
//  ApiMarvel_Characters.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import Alamofire

extension ApiMarvel {
    
    /**
     Characters
     
     Fetches lists of comic characters with optional filters.

     How to use?
     =======================
     https://developer.marvel.com/docs#!/public/getCreatorCollection_get_0
     
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
    
    open func characters(requestData: PaginationRequest,
                         completion: @escaping (Result<[CharacterResponse], Error>) -> Void) {
        
//        let apiClient = APIClient(session: self.session)
        
        let endpoint = ApiMarvelEndpoints.characters(requestData)
        
        self.httpClient.request(from: endpoint, of: CharacterDataWrapperResponse.self) { response in
            
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
