//
//  HeroDetailViewData.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

struct HeroDetailViewData: Identifiable {
    var id: Int
    var name: String
    var avatarURL: URL?
    var description: String
    var comics: [ComicViewData]
    var series: [SerieViewData]
    var stories: [StoryViewData]
}
