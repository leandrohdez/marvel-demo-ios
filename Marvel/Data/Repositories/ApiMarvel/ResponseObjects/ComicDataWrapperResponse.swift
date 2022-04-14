//
//  ComicDataWrapperResponse.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

struct ComicDataWrapperResponse: Decodable {
    let code: Int
    let status: String
    let data: ComicDataContainerResponse
}
