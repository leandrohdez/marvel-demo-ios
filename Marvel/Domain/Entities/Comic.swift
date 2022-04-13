//
//  Comic.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

open class Comic: Equatable {
    
    let id: Int
    
    let title: String
    
    let imageUrl: String
    
    //
    init(id: Int, title: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
    }
    
    //
    public static func == (lhs: Comic, rhs: Comic) -> Bool {
        return (lhs.id == rhs.id)
    }
}
