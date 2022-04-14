//
//  HeroUseCase.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation
import PromiseKit

final class HeroUseCase {
    
    // input
    private var input: HeroUseCaseInput!
    
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
extension HeroUseCase: HeroUseCaseProtocol {
    
    //
    func execute(input: HeroUseCaseInput, completion: @escaping (HeroUseCaseResult) -> Void) {
        
        self.input = input
        
        firstly {
            when(fulfilled: self.fetchCharacter(), self.fetchComics(), self.fetchSeries(), self.fetchStories())

        }.done { hero, comics, series, stories in

            hero.comics = comics
            hero.series = series
            hero.stories = stories

            let output = HeroUseCaseOutput(hero: hero)
            completion(HeroUseCaseResult.success(output))

        }.catch { error in
            completion(HeroUseCaseResult.failure(error))
        }
    }
    
}

// MARK: - Methods
extension HeroUseCase {
    
    //
    private func fetchCharacter() -> Promise<Hero> {
        return Promise<Hero> { seal in

            let requestData = CharacterRequest(id: self.input.heroId)

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

    //
    private func fetchComics() -> Promise<[Comic]> {
        return Promise<[Comic]> { seal in

            let requestData = CharacterRequest(id: self.input.heroId)

            self.dependencies.apiMarvelRepository.comics(requestData: requestData) { result in

                switch result {

                case .success(let responseData):
                    let comics: [Comic] = responseData.map { comicResponse in
                        Comic(dto: comicResponse)
                    }

                    seal.fulfill(comics)

                case .failure(_):
                    seal.fulfill([])
                }
            }
        }
    }

    //
    private func fetchSeries() -> Promise<[Serie]> {
        return Promise<[Serie]> { seal in

            let requestData = CharacterRequest(id: self.input.heroId)

            self.dependencies.apiMarvelRepository.series(requestData: requestData) { result in

                switch result {

                case .success(let responseData):

                    let series: [Serie] = responseData.map { serieResponse in
                        Serie(dto: serieResponse)
                    }

                    seal.fulfill(series)

                case .failure(_):
                    seal.fulfill([])
                }
            }
        }
    }

    //
    private func fetchStories() -> Promise<[Story]> {
        return Promise<[Story]> { seal in

            let requestData = CharacterRequest(id: self.input.heroId)

            self.dependencies.apiMarvelRepository.stories(requestData: requestData) { result in

                switch result {

                case .success(let responseData):

                    let stories: [Story] = responseData.map { storyResponse in
                        Story(dto: storyResponse)
                    }

                    seal.fulfill(stories)

                case .failure(_):
                    seal.fulfill([])
                }
            }
        }
    }
}
