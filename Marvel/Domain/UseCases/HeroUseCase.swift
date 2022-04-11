//
//  HeroUseCase.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import PromiseKit

enum HeroCaseResult {
    case success(hero: Hero)
    case notFound
    case unknownError
}

class HeroUseCase: BaseUseCase {
    
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    // run case
    override func execute() {
        super.execute()
        self.runPromisesRules()
    }
    
}

// MARK: - Methods
extension HeroUseCase {
    
    //
    private func runPromisesRules() {
        
        firstly {
            when(fulfilled: self.fetchCharacter(), self.fetchComics(), self.fetchSeries(), self.fetchStories())
            
        }.done { hero, comics, series, stories in
            
            hero.comics = comics
            hero.series = series
            hero.stories = stories
            
            self.finish(caseResult: HeroCaseResult.success(hero: hero))
            
        }.catch { error in
            if let serviceError = error as? ApiMarvelError, serviceError == ApiMarvelError.notFound {
                self.finish(caseResult: HeroCaseResult.notFound)
            } else {
                self.finish(caseResult: HeroCaseResult.unknownError)
            }
        }
    }
    
    //
    private func fetchCharacter() -> Promise<Hero> {
        return Promise<Hero> { seal in
            
            let requestData = CharacterRequest(id: self.id)
            
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
    
    //
    private func fetchComics() -> Promise<[Comic]> {
        return Promise<[Comic]> { seal in
            
            let requestData = CharacterRequest(id: self.id)
            
            ApiMarvel.shared.comics(requestData: requestData) { result in
                
                switch result {
                    
                case .success(let responseData):
                    let comics: [Comic] = responseData.map { comicResponse in
                        Comic(dto: comicResponse)
                    }
                    
                    seal.fulfill(comics)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    //
    private func fetchSeries() -> Promise<[Serie]> {
        return Promise<[Serie]> { seal in
            
            let requestData = CharacterRequest(id: self.id)
            
            ApiMarvel.shared.series(requestData: requestData) { result in
                
                switch result {
                    
                case .success(let responseData):
                    
                    let series: [Serie] = responseData.map { serieResponse in
                        Serie(dto: serieResponse)
                    }
                    
                    seal.fulfill(series)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    //
    private func fetchStories() -> Promise<[Story]> {
        return Promise<[Story]> { seal in
            
            let requestData = CharacterRequest(id: self.id)
            
            ApiMarvel.shared.stories(requestData: requestData) { result in
                
                switch result {
                    
                case .success(let responseData):
                    
                    let stories: [Story] = responseData.map { storyResponse in
                        Story(dto: storyResponse)
                    }
                    
                    seal.fulfill(stories)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
}
