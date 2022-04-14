//
//  SerieDataContainerResponse.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

struct SerieDataContainerResponse: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [SerieResponse]
}
