//
//  ApiMarvelEndpoints.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import Alamofire
import SwiftHash

enum ApiMarvelEndpoints: URLRequestConvertible {
    
    ///
    case characters(PaginationRequest)
    
    case character(CharacterRequest)
    
    case comics(CharacterRequest)
    
    case series(CharacterRequest)
    
    case stories(CharacterRequest)
    
    ///
    ///
    var path: String {
        
        switch self {
        
        case .characters:                           return "/v1/public/characters"
        case .character(let requestData):           return "/v1/public/characters/\(requestData.characterId)"
        case .comics(let requestData):              return "/v1/public/characters/\(requestData.characterId)/comics"
        case .series(let requestData):              return "/v1/public/characters/\(requestData.characterId)/series"
        case .stories(let requestData):             return "/v1/public/characters/\(requestData.characterId)/stories"
        }
    }
    
    ///
    ///
    var method: HTTPMethod {
        
        switch self {
            
        case .characters:                   return .get
        case .character:                    return .get
        case .comics:                       return .get
        case .series:                       return .get
        case .stories:                      return .get
        }
    }
    
    ///
    ///
    var parameters: [String: Any]? {
        
        switch self {
            
        case .characters(let pagination):
            let now = Date()
            return [
                "offset": pagination.offset,
                "limit": pagination.limit,
                "ts": String(now.timeIntervalSince1970),
                "apikey": ApiMarvel.shared.publicKey,
                "hash": ApiMarvel.shared.hash(date: now)
            ]
            
        case .character:
            let now = Date()
            return [
                "ts": String(now.timeIntervalSince1970),
                "apikey": ApiMarvel.shared.publicKey,
                "hash": ApiMarvel.shared.hash(date: now)
            ]
            
        case .comics:
            let now = Date()
            return [
                "ts": String(now.timeIntervalSince1970),
                "apikey": ApiMarvel.shared.publicKey,
                "hash": ApiMarvel.shared.hash(date: now)
            ]
            
        case .series:
            let now = Date()
            return [
                "ts": String(now.timeIntervalSince1970),
                "apikey": ApiMarvel.shared.publicKey,
                "hash": ApiMarvel.shared.hash(date: now)
            ]
            
        case .stories:
            let now = Date()
            return [
                "ts": String(now.timeIntervalSince1970),
                "apikey": ApiMarvel.shared.publicKey,
                "hash": ApiMarvel.shared.hash(date: now)
            ]
        }
    }
    
    ///
    ///
    func asURLRequest() throws -> URLRequest {
        let url = try ApiMarvel.shared.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
            
        case .characters,
             .character,
             .comics,
             .series,
             .stories:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
        }
        
        return urlRequest
    }
}
