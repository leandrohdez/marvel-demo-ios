//
//  Story_convenience.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

extension Story {
    
    //
    convenience init(dto story: StoryResponse) {
        
        let fullurl = "\(story.thumbnail?.path ?? "").\(story.thumbnail?.ext ?? "")"
        
        self.init(
            id: story.id,
            title: story.title,
            imageUrl: (fullurl != ".") ? fullurl : ""
        )
    }
    
}
