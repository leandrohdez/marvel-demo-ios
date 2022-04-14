//
//  MockMainController.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation
@testable import Marvel

class MockMainController: MainPresenterView {

    var heroesViewData: [HeroViewData]?
    
    var mostPopularHeroes: [HeroViewData]?
    
    var presenter: MainPresenter!
    
    func performHeroes(heroesViewData: [HeroViewData]) {
        self.heroesViewData = heroesViewData
    }
    
    func performMostPopularHeroes(heroesViewData: [HeroViewData]) {
        self.mostPopularHeroes = heroesViewData
    }
    
    func startLoading() { }
    
    func stopLoading() { }
}
