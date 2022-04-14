//
//  HeroesUseCase.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation
import PromiseKit

final class HeroesUseCase {
    
    // input
    private var input: HeroesUseCaseInput!
    
    // dependencies
    private let dependencies: Dependency
    struct Dependency {
        let apiMarvelRepository: ApiMarvelRepository
    }
    
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
extension HeroesUseCase: HeroesUseCaseProtocol {
    
    //
    func execute(input: HeroesUseCaseInput, completion: @escaping (HeroesUseCaseResult) -> Void) {
        
        self.input = input
        
        firstly {
            self.fetchCharacters()
            
        }.done { heroes in
            let output = HeroesUseCaseOutput(heroes: heroes)
            completion(HeroesUseCaseResult.success(output))
            
        }.catch { error in
            completion(HeroesUseCaseResult.failure(error))
        }
    }
    
}

// MARK: - Methods
extension HeroesUseCase {
    
    //
    private func fetchCharacters() -> Promise<[Hero]> {
        return Promise<[Hero]> { seal in

            let offset =  self.input.pageIndex * self.input.pageLength

            let requestData = PaginationRequest(offset: offset, limit: self.input.pageLength)

            self.dependencies.apiMarvelRepository.characters(requestData: requestData) { result in

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
