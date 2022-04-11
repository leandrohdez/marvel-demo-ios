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
    
    private weak var view: MainPresenterView?
    
    //
    private var isAllowLoadMore: Bool = true
    
    private var pageIndex: Int = 0
    
    private var pageLength: Int = 100
    
    private var heroes: [Hero] = []
    
    //
    init(view: MainPresenterView) {
        self.view = view
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
        
        view.startLoading()
        SuperHeroDomain.UseCases.heroes(pageIndex: self.pageIndex, pageLength: self.pageLength) { result in
            view.stopLoading()
            
            switch result {
                
            case .success(let heroes):
                
                self.heroes += heroes
                
                let heroesViewData: [HeroViewData] = heroes.map {
                    HeroViewData(
                        id: $0.id,
                        name: $0.name,
                        avatarURL: URL(string: $0.imageUrl),
                        description: $0.description
                    )
                }
                
                view.performHeroes(heroesViewData: heroesViewData)
                
                // [] means no more items
                self.isAllowLoadMore = (heroes.count > 0)
 
            case .unknownError:
                view.showMessage(title: "Something bad happened", text: "Never miss an error message.")
            }
        }
    }
    
    //
    private func fetchMostPupularHeroes() {
        guard let view = self.view else { return }
        SuperHeroDomain.UseCases.mostPopulars { result in
            
            switch result {
            case .success(let heroes):
                
                let heroesViewData: [HeroViewData] = heroes.map {
                    HeroViewData(
                        id: $0.id,
                        name: $0.name,
                        avatarURL: URL(string: $0.imageUrl),
                        description: $0.description
                    )
                }
                
                view.performMostPopularHeroes(heroesViewData: heroesViewData)
            }
        }
    }
    
}

// MARK: - Navigations
extension MainPresenter {
    
    //
    private func navigateToDetail(hero: Hero) {
        guard let view = self.view as? MainViewController else { return }
        RouterController(from: view).pushDetailViewController(hero: hero)
    }
    
}
