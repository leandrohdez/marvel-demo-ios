//
//  ApiMarvel.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import SwiftHash
import Alamofire

class ApiMarvel: ApiMarvelRepository {

    static let shared = ApiMarvel()
    
    // properties api
    let baseURL     = "https://gateway.marvel.com"
    
    let privateKey  = "9f6fb5befd1311be7464147fde699388d68f451c"
    
    let publicKey   = "c864b8acb6653f0d5710d4de37a3f246"
    
    // http client
    let httpClient: HttpClient
    
    //
    init(client: HttpClient = HttpClient()) {
        self.httpClient = client
    }
    
}

// MARK: Hash
extension ApiMarvel {
    
    //
    public func hash(date: Date) -> String {

        let ts = String(date.timeIntervalSince1970)
        
        let privateKey = ApiMarvel.shared.privateKey
        let publicKey = ApiMarvel.shared.publicKey
        
        return MD5(ts + privateKey + publicKey).lowercased()
    }
    
}
