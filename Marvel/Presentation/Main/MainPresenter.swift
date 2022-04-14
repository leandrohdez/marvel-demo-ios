//
//  MainPresenter.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation

protocol MainPresenterView: BasePresenterView {
    func performHeroes(heroesViewData: [HeroViewData])
    func performMostPopularHeroes(heroesViewData: [HeroViewData])
}

class MainPresenter: BasePresenter {
    
    // view dependency
    private weak var view: MainPresenterView?
    
    // use case dependencies
    struct UseCases {
        let heroes: HeroesUseCaseProtocol
        let topFive: TopFiveUseCaseProtocol
    }
    
    private let usecases: UseCases
    
    // Properties
    private var isAllowLoadMore: Bool = true
    
    private var pageIndex: Int = 0
    
    private var pageLength: Int = 100
    
    private var heroes: [Hero] = []
    
    //
    init(view: MainPresenterView, usecases: UseCases) {
        self.view = view
        self.usecases = usecases
    }
    
    override func viewDidLoad() {
        self.fetchHeroes()
        self.fetchMostPupularHeroes()
    }
}

// MARK: - Actions
extension MainPresenter {
 
    //
    func reloadAction() {
        self.isAllowLoadMore = true
        self.pageIndex = 0
        self.fetchHeroes()
    }
    
    //
    func loadMoreAction() {
        if self.isAllowLoadMore {
            self.isAllowLoadMore = false
            self.pageIndex += 1
            self.fetchHeroes()
        }
    }
    
    //
    func detailAction(heroId: Int) {
        guard let hero = self.heroes.first(where: { $0.id == heroId }) else { return }
        self.navigateToDetail(hero: hero)
    }
    
}

// MARK: - Methods
extension MainPresenter {
    
    //
    private func fetchHeroes() {
        
        guard let view = self.view else { return }
        
        let input = HeroesUseCaseInput(pageIndex: self.pageIndex, pageLength: self.pageLength)
        
        view.startLoading()
        self.usecases.heroes.execute(input: input) { result in
            view.stopLoading()
            
            switch result {
                
            case .success(let output):
                
                self.heroes += output.heroes

                let heroesViewData: [HeroViewData] = output.heroes.map {
                    HeroViewData(
                        id: $0.id,
                        name: $0.name,
                        avatarURL: URL(string: $0.imageUrl),
                        description: $0.description
                    )
                }

                view.performHeroes(heroesViewData: heroesViewData)

                // [] means no more items
                self.isAllowLoadMore = (output.heroes.count > 0)
                
            case .failure(_):
                view.showMessage(title: "Something bad happened", text: "Never miss an error message.")
            }
        }
    }
    
    //
    private func fetchMostPupularHeroes() {
        
        guard let view = self.view else { return }
        
        self.usecases.topFive.execute { result in
            
            switch result {
                
            case .success(let output):
                
                let heroesViewData: [HeroViewData] = output.heroes.map {
                    HeroViewData(
                        id: $0.id,
                        name: $0.name,
                        avatarURL: URL(string: $0.imageUrl),
                        description: $0.description
                    )
                }
                
                view.performMostPopularHeroes(heroesViewData: heroesViewData)
                
            case .failure(_):
                break
            }
        }
    }
    
}

// MARK: - Navigations
extension MainPresenter {
    
    //
    private func navigateToDetail(hero: Hero) {
        guard let view = self.view as? MainViewController else { return }
        FlowCoordinator(from: view).pushDetailViewController(hero: hero)
    }
    
}
