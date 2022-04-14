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
    
    // view dependency
    private weak var view: DetailPresenterView?
  
    // use case dependencies
    struct UseCases {
        let hero: HeroUseCaseProtocol
    }
    
    private let usecases: UseCases
    
    // objects
    public var hero: Hero!
    
    //
    init(view: DetailPresenterView, usecases: UseCases) {
        self.view = view
        self.usecases = usecases
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
        
        let input = HeroUseCaseInput(heroId: self.hero.id)
        
        view.startLoading()
        self.usecases.hero.execute(input: input) { result in
            view.stopLoading()
            
            switch result {
                
            case .success(let output):
                
                // rewrite
                self.hero = output.hero
                
                let comics: [ComicViewData] = output.hero.comics.map { comic in
                    ComicViewData(id: comic.id, title: comic.title, coverURL: URL(string: comic.imageUrl))
                }
                
                let series: [SerieViewData] = output.hero.series.map { serie in
                    SerieViewData(id: serie.id, title: serie.title, coverURL: URL(string: serie.imageUrl))
                }
                
                let stories: [StoryViewData] = output.hero.stories.map { story in
                    StoryViewData(id: story.id, title: story.title, coverURL: URL(string: story.imageUrl))
                }
                
                view.performHero(
                    heroViewData: HeroDetailViewData(
                        id: output.hero.id,
                        name: output.hero.name,
                        avatarURL: URL(string: output.hero.imageUrl),
                        description: output.hero.description,
                        comics: comics,
                        series: series,
                        stories: stories
                    )
                )
                
            case .failure(_):
                view.showMessage(title: "Something bad happened", text: "Never miss an error message.", buttonTitle: "Back") {
                    self.backDismissNavigation()
                }
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
