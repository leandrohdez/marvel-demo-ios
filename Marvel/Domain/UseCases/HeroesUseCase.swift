//
//  HeroesUseCase.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import PromiseKit

enum HeroesCaseResult {
    case success(heroes: [Hero])
    case unknownError
}

class HeroesUseCase: BaseUseCase {
    
    private let pageIndex: Int
    
    private let pageLength: Int
    
    init(pageIndex: Int, pageLength: Int) {
        self.pageIndex = pageIndex
        self.pageLength = pageLength
    }
    
    // run case
    override func execute() {
        super.execute()
        self.runPromisesRules()
    }
    
}

// MARK: - Methods
extension HeroesUseCase {
    
    //
    private func runPromisesRules() {
        firstly {
            self.fetchCharacters()
        }.done { heroes in
            self.finish(caseResult: HeroesCaseResult.success(heroes: heroes))
        }.catch { _ in
            self.finish(caseResult: HeroesCaseResult.unknownError)
        }
    }
    
    //
    private func fetchCharacters() -> Promise<[Hero]> {
        return Promise<[Hero]> { seal in
            
            let offset =  self.pageIndex * self.pageLength
            
            let requestData = PaginationRequest(offset: offset, limit: self.pageLength)
            
            ApiMarvel.shared.characters(requestData: requestData) { result in
                
                switch result {
                    
                case .success(let charactersResponse):
                    
                    let heroes: [Hero] = charactersResponse.map { characterResponse in
                        Hero(dto: characterResponse)
                    }
                    
                    seal.fulfill(heroes)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
}
