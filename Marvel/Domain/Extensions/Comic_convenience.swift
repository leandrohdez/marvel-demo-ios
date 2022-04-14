//
//  Comic_convenience.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

extension Comic {
    
    //
    convenience init(dto comic: ComicResponse) {
        
        self.init(
            id: comic.id,
            title: comic.title,
            imageUrl: comic.thumbnail.path + "." + comic.thumbnail.ext
        )
    }
    
}
