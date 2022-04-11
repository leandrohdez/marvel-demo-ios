//
//  PopularHeroesUseCase.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import PromiseKit

enum PopularHeroesCaseResult {
    case success(heroes: [Hero])
}

class PopularHeroesUseCase: BaseUseCase {
    
    private let heroTop1: Int = 1009146     // Abomination
    
    private let heroTop2: Int = 1010801     // AntMan
    
    private let heroTop3: Int = 1009184     // Black Bolt
    
    private let heroTop4: Int = 1011130     // Black Phanter
    
    private let heroTop5: Int = 1009216     // Caliban
    
    //
    override init() {
        
    }
    
    // run case
    override func execute() {
        super.execute()
        self.runPromisesRules()
    }
    
}

// MARK: - Methods
extension PopularHeroesUseCase {
    
    //
    private func runPromisesRules() {
        
        firstly {
            when(fulfilled:
                 self.fetchCharacter(id: self.heroTop1),
                 self.fetchCharacter(id: self.heroTop2),
                 self.fetchCharacter(id: self.heroTop3),
                 self.fetchCharacter(id: self.heroTop4),
                 self.fetchCharacter(id: self.heroTop5)
            )
            
        }.done { hero1, hero2, hero3, hero4, hero5 in
            
            self.finish(caseResult: PopularHeroesCaseResult.success(heroes: [hero1, hero2, hero3, hero4, hero5]))
            
        }.catch { _ in
            self.finish(caseResult: PopularHeroesCaseResult.success(heroes: []))
        }
    }
    
    //
    private func fetchCharacter(id: Int) -> Promise<Hero> {
        return Promise<Hero> { seal in
            
            let requestData = CharacterRequest(id: id)
            
            ApiMarvel.shared.character(requestData: requestData) { result in
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
