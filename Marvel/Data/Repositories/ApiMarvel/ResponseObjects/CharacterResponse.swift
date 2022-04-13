//
//  CharacterResponse.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

struct CharacterResponse: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailResponse
    let urls: [CharacterURLResponse]
}
