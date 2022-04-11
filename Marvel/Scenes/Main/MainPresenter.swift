//
//  MainPresenter.swift
//  Marvel
//
//  Created by Leandro Hernandez on 17/3/22.
//

import Foundation

protocol MainPresenterView: BasePresenterView {
    
}

class MainPresenter: BasePresenter {
    
    private weak var view: MainPresenterView?
    
    init(view: MainPresenterView) {
        self.view = view
    }
}

// MARK: - Actions
extension MainPresenter {
 
    //
    func detailAction() {
        self.navigateToDetail()
    }
    
}

// MARK: - Methods
extension MainPresenter {
    
}

// MARK: - Navigations
extension MainPresenter {
    
    //
    private func navigateToDetail() {
        guard let view = self.view as? MainViewController else { return }
        let controller: DetailViewController = ServiceLocator.inject()
        view.navigationController?.pushViewController(controller, animated: true)
    }
    
}
