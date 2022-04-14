//
//  File.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation
@testable import Marvel

protocol MockApiMarvelRepository: ApiMarvelRepository {
    
}

// Para facilitar el mock
extension MockApiMarvelRepository {
     
     //
     func characters(requestData: PaginationRequest, completion: @escaping (Result<[CharacterResponse], Error>) -> Void) { }
     
     //
     func character(requestData: CharacterRequest, completion: @escaping (Result<CharacterResponse, Error>) -> Void) { }
     
     //
     func comics(requestData: CharacterRequest, completion: @escaping (Result<[ComicResponse], Error>) -> Void) { }
     
     //
     func series(requestData: CharacterRequest, completion: @escaping (Result<[SerieResponse], Error>) -> Void) { }
     
     //
     func stories(requestData: CharacterRequest, completion: @escaping (Result<[StoryResponse], Error>) -> Void) { }
}
