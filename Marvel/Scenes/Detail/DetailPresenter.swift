//
//  DetailPresenter.swift
//  Marvel
//
//  Created by Leandro Hernandez on 17/3/22.
//

import Foundation

protocol DetailPresenterView: BasePresenterView {
    
}

class DetailPresenter: BasePresenter {
    
    private weak var view: DetailPresenterView?
    
    init(view: DetailPresenterView) {
        self.view = view
    }
}

// MARK: - Actions
extension DetailPresenter {
    
}

// MARK: - Methods
extension DetailPresenter {
    
}

// MARK: - Navigations
extension DetailPresenter {
    
}
