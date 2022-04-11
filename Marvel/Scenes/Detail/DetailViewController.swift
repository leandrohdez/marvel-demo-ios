//
//  DetailViewController.swift
//  Marvel
//
//  Created by Leandro Hernandez on 17/3/22.
//

import UIKit

class DetailViewController: BaseViewController {

    // MARK: Properties
    // ...
    
    // MARK: Outlets
    // ...
    
    // MARK: Presenter
    var detailPresenter: DetailPresenter!
    override var presenter: DetailPresenter! {
        return detailPresenter
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.title = "Detail"
    }
    
    override func startLoading() {
        super.startLoading()
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = false
    }
    
    override func stopLoading() {
        super.stopLoading()
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = true
    }
}

// MARK: - Presenter Methods
extension DetailViewController: DetailPresenterView {
    
}

// MARK: - Actions
extension DetailViewController {
    
}

// MARK: - Methods
extension DetailViewController {
    
}
