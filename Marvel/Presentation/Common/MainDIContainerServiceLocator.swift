//
//  MainServiceLocator.swift
//  Marvel
//
//  Created by Leandro Hernandez on 17/3/22.
//

import Foundation

class MainDIContainerServiceLocator: ServiceLocatorModule {
    
    func registerServices(serviceLocator: ServiceLocator) {
        serviceLocator.register { self.provideMainViewController() }
        serviceLocator.register { self.provideDetailViewController() }
    }
    
    private func provideMainViewController() -> MainViewController {
        let viewController = MainViewController(nibName: "MainViewController", bundle: Bundle.main)
        viewController.mainPresenter = MainPresenter(
            view: viewController,
            usecases: MainPresenter.UseCases(
                heroes: HeroesUseCase(),
                topFive: TopFiveUseCase()
            )
        )
        return viewController
    }
    
    private func provideDetailViewController() -> DetailViewController {
        let viewController = DetailViewController(nibName: "DetailViewController", bundle: Bundle.main)
        viewController.detailPresenter = DetailPresenter(
            view: viewController,
            usecases: DetailPresenter.UseCases(
                hero: HeroUseCase()
            )
        )
        return viewController
    }
    
}
