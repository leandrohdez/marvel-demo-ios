//
//  StoryDataContainerResponse.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

struct StoryDataContainerResponse: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [StoryResponse]
}
