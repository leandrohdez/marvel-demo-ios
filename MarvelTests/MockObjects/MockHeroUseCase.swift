//
//  MockHeroUseCase.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation
@testable import Marvel

class MockHeroUseCaseSuccess: HeroUseCaseProtocol {
    
    func execute(input: HeroUseCaseInput, completion: @escaping (HeroUseCaseResult) -> Void) {
        
        let mockHero = Hero(id: 1, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        
        mockHero.comics.append(
            Comic(id: 1, title: "Comic title", imageUrl: "https://via.placeholder.com/80")
        )
        
        mockHero.series.append(
            Serie(id: 1, title: "Serie title", imageUrl: "https://via.placeholder.com/80")
        )
        
        let output = HeroUseCaseOutput(hero: mockHero)
        completion(HeroUseCaseResult.success(output))
    }

}

class MockHeroUseCaseFail: HeroUseCaseProtocol {
    
    func execute(input: HeroUseCaseInput, completion: @escaping (HeroUseCaseResult) -> Void) {
        completion(HeroUseCaseResult.failure(MockUseCaseError.error))
    }

}
