//
//  DetailPresenter.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation

protocol DetailPresenterView: BasePresenterView {
    func performHero(heroViewData: HeroDetailViewData)
}

class DetailPresenter: BasePresenter {
    
    private weak var view: DetailPresenterView?
    
    public var hero: Hero!
    
    init(view: DetailPresenterView) {
        self.view = view
    }
    
    override func viewDidLoad() {
        self.fetchDetailHero()
        
        let viewData = HeroDetailViewData(
            id: self.hero.id,
            name: self.hero.name,
            avatarURL: URL(string: self.hero.imageUrl),
            description: self.hero.description,
            comics: [],
            series: [],
            stories: []
        )
        self.view?.performHero(heroViewData: viewData)
    }
}

// MARK: - Actions
extension DetailPresenter {
    
}

// MARK: - Methods
extension DetailPresenter {
    
    //
    private func fetchDetailHero() {
        
        guard let view = self.view else { return }
        
        view.startLoading()
        SuperHeroDomain.UseCases.hero(id: self.hero.id) { result in
            view.stopLoading()
            
            switch result {
                
            case .success(let hero):
                
                // rewrite
                self.hero = hero
                
                let comics: [ComicViewData] = hero.comics.map { comic in
                    ComicViewData(id: comic.id, title: comic.title, coverURL: URL(string: comic.imageUrl))
                }
                
                let series: [SerieViewData] = hero.series.map { serie in
                    SerieViewData(id: serie.id, title: serie.title, coverURL: URL(string: serie.imageUrl))
                }
                
                let stories: [StoryViewData] = hero.stories.map { story in
                    StoryViewData(id: story.id, title: story.title, coverURL: URL(string: story.imageUrl))
                }
                
                view.performHero(
                    heroViewData: HeroDetailViewData(
                        id: hero.id,
                        name: hero.name,
                        avatarURL: URL(string: hero.imageUrl),
                        description: hero.description,
                        comics: comics,
                        series: series,
                        stories: stories
                    )
                )
                
            case .notFound:
                view.showMessage(title: "Not found", text: "We can't find this super hero anywhere.", buttonTitle: "Back") {
                    self.backDismissNavigation()
                }
                
            case .unknownError:
                view.showMessage(title: "Something bad happened", text: "Never miss an error message.")
            
            }
        }
    }
}

// MARK: - Navigations
extension DetailPresenter {
    
    //
    private func backDismissNavigation() {
        guard let sender = self.view as? DetailViewController else { return }
        sender.navigationController?.popViewController(animated: true)
    }
    
}
