//
//  CharacterDataWrapperResponse.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

struct CharacterDataWrapperResponse: Decodable {
    let code: Int
    let status: String
    let data: CharacterDataContainerResponse
}
