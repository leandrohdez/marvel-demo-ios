//
//  MockHeroesUseCase.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation
@testable import Marvel

class MockHeroesUseCaseSuccess: HeroesUseCaseProtocol {
    
    func execute(input: HeroesUseCaseInput, completion: @escaping (HeroesUseCaseResult) -> Void) {
        
        let mockHero01 = Hero(id: 1, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero02 = Hero(id: 2, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero03 = Hero(id: 3, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero04 = Hero(id: 4, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero05 = Hero(id: 5, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero06 = Hero(id: 6, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero07 = Hero(id: 7, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero08 = Hero(id: 8, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero09 = Hero(id: 9, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero10 = Hero(id: 10, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        
        let output = HeroesUseCaseOutput(heroes: [mockHero01, mockHero02, mockHero03, mockHero04, mockHero05, mockHero06, mockHero07, mockHero08, mockHero09, mockHero10])
        
        completion(HeroesUseCaseResult.success(output))
    }

}

class MockHeroesUseCaseEmpty: HeroesUseCaseProtocol {
    
    func execute(input: HeroesUseCaseInput, completion: @escaping (HeroesUseCaseResult) -> Void) {
        let output = HeroesUseCaseOutput(heroes: [])
        completion(HeroesUseCaseResult.success(output))
    }

}

class MockHeroesUseCaseFail: HeroesUseCaseProtocol {
    
    func execute(input: HeroesUseCaseInput, completion: @escaping (HeroesUseCaseResult) -> Void) {
        completion(HeroesUseCaseResult.failure(MockUseCaseError.error))
    }

}
