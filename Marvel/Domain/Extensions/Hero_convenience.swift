//
//  Hero_convenience.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

extension Hero {
    
    //
    convenience init(dto hero: CharacterResponse) {
        
        var urls: [String] = []
        hero.urls.forEach { url in
            urls.append(url.url)
        }
        
        self.init(
            id: hero.id,
            name: hero.name,
            description: hero.description,
            imageUrl: hero.thumbnail.path + "." + hero.thumbnail.ext,
            urls: urls
        )
    }
    
}
