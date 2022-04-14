//
//  TopFiveUseCase.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation
import PromiseKit

final class TopFiveUseCase {
    
    // dependencies
    private let dependencies: Dependency
    struct Dependency {
        let apiMarvelRepository: ApiMarvelRepository
    }
    
    // Use case properties
    private let heroTop1: Int = 1009146     // Abomination (its a example)
    
    private let heroTop2: Int = 1010913     // Captain America (its a example)
    
    private let heroTop3: Int = 1009184     // Black Bolt (its a example)
    
    private let heroTop4: Int = 1011130     // Black Phanter (its a example)
    
    private let heroTop5: Int = 1009216     // Caliban (its a example)
    
    //
    init() {
        self.dependencies = Dependency(
            apiMarvelRepository: ApiMarvel()
        )
    }
    
    init(dependencies: Dependency) {
        self.dependencies = dependencies
    }
    
}

// MARK: - Run Use Case
extension TopFiveUseCase: TopFiveUseCaseProtocol {
    
    //
    func execute(completion: @escaping (TopFiveUseCaseResult) -> Void) {
        
        firstly {
            when(fulfilled:
                 self.fetchCharacter(id: self.heroTop1),
                 self.fetchCharacter(id: self.heroTop2),
                 self.fetchCharacter(id: self.heroTop3),
                 self.fetchCharacter(id: self.heroTop4),
                 self.fetchCharacter(id: self.heroTop5)
            )
            
        }.done { hero1, hero2, hero3, hero4, hero5 in
            
            let output = TopFiveUseCaseOutput(heroes: [hero1, hero2, hero3, hero4, hero5])
            completion(TopFiveUseCaseResult.success(output))
            
        }.catch { _ in
            completion(TopFiveUseCaseResult.success(TopFiveUseCaseOutput(heroes: [])))
        }
    }
    
}

// MARK: - Methods
extension TopFiveUseCase {
    
    //
    private func fetchCharacter(id: Int) -> Promise<Hero> {
        return Promise<Hero> { seal in
            
            let requestData = CharacterRequest(id: id)
            
            self.dependencies.apiMarvelRepository.character(requestData: requestData) { result in
                switch result {
                    
                case .success(let responseData):
                    seal.fulfill(Hero(dto: responseData))
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
