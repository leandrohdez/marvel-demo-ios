//
//  SerieResponse.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

struct SerieResponse: Decodable {
    let id: Int
    let title: String
    let thumbnail: ThumbnailResponse
}
