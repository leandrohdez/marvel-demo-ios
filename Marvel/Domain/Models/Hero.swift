//
//  Hero.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

open class Hero: Equatable {
    
    let id: Int
    
    let name: String
    
    let description: String
    
    let imageUrl: String
    
    var urls: [String] = []
    
    var comics: [Comic] = []
    
    var series: [Serie] = []
    
    var stories: [Story] = []
    
    //
    init(id: Int, name: String, description: String, imageUrl: String, urls: [String] = []) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.urls = urls
    }
    
    //
    public static func == (lhs: Hero, rhs: Hero) -> Bool {
        return (lhs.id == rhs.id)
    }
    
}
