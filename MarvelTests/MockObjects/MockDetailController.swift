//
//  MockDetailController.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation
@testable import Marvel

class MockDetailController: DetailPresenterView {
    
    var heroViewData: HeroDetailViewData?
    
    var presenter: DetailPresenter!
    
    func performHero(heroViewData: HeroDetailViewData) {
        self.heroViewData = heroViewData
    }
    
    func startLoading() { }
    
    func stopLoading() { }
}
