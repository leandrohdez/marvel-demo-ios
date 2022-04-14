//
//  MockTopFiveUseCase.swift
//  MarvelTests
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation
@testable import Marvel

class MockTopFiveUseCaseSuccess: TopFiveUseCaseProtocol {
    
    func execute(completion: @escaping (TopFiveUseCaseResult) -> Void) {
        
        let mockHero01 = Hero(id: 1, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero02 = Hero(id: 2, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero03 = Hero(id: 3, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero04 = Hero(id: 4, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        let mockHero05 = Hero(id: 5, name: "Superhero", description: "Description", imageUrl: "https://via.placeholder.com/80")
        
        let output = TopFiveUseCaseOutput(heroes: [mockHero01, mockHero02, mockHero03, mockHero04, mockHero05])
        
        completion(TopFiveUseCaseResult.success(output))
    }

}

class MockTopFiveUseCaseEmpty: TopFiveUseCaseProtocol {
    
    func execute(completion: @escaping (TopFiveUseCaseResult) -> Void) {
        let output = TopFiveUseCaseOutput(heroes: [])
        completion(TopFiveUseCaseResult.success(output))
    }

}

class MockTopFiveUseCaseFail: TopFiveUseCaseProtocol {
    
    func execute(completion: @escaping (TopFiveUseCaseResult) -> Void) {
        completion(TopFiveUseCaseResult.failure(MockUseCaseError.error))
    }

}
