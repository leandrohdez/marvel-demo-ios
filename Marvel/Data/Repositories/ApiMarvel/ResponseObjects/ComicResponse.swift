//
//  ComicResponse.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

struct ComicResponse: Decodable {
    let id: Int
    let title: String
    let thumbnail: ThumbnailResponse
}
