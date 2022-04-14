//
//  Serie_convenience.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

extension Serie {
    
    //
    convenience init(dto serie: SerieResponse) {
        
        self.init(
            id: serie.id,
            title: serie.title,
            imageUrl: serie.thumbnail.path + "." + serie.thumbnail.ext
        )
    }
    
}
