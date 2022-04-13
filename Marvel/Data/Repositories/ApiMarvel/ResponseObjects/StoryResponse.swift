//
//  StoryResponse.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

struct StoryResponse: Decodable {
    let id: Int
    let title: String
    let thumbnail: ThumbnailResponse?
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case title = "title"
        case thumbnail = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        
        do {
            self.thumbnail = try values.decode(ThumbnailResponse?.self, forKey: .thumbnail)
        } catch {
            self.thumbnail = nil
        }
    }
}
