//
//  ApiMarvelRepository.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation

protocol ApiMarvelRepository: ApiRepository {
    
    /// Characters
    /// Fetches lists of comic characters with optional filters.
    func characters(requestData: PaginationRequest, completion: @escaping (Result<[CharacterResponse], Error>) -> Void)
    
    /// Character
    /// Detail of comic character.
    func character(requestData: CharacterRequest, completion: @escaping (Result<CharacterResponse, Error>) -> Void)
    
    /// Comics
    /// Fetches lists of comics about of character.
    func comics(requestData: CharacterRequest, completion: @escaping (Result<[ComicResponse], Error>) -> Void)
    
    /// Series
    /// Fetches series of comics about of character.
    func series(requestData: CharacterRequest, completion: @escaping (Result<[SerieResponse], Error>) -> Void)
    
    /// Stories
    /// Fetches stories of comics about of character.
    func stories(requestData: CharacterRequest, completion: @escaping (Result<[StoryResponse], Error>) -> Void)
    
}
