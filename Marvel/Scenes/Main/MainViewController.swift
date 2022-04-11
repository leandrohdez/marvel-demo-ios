//
//  MainViewController.swift
//  Marvel
//
//  Created by Leandro Hernandez on 17/3/22.
//

import UIKit

class MainViewController: BaseViewController {

    // MARK: Properties
    // ...
    
    // MARK: Outlets
    @IBOutlet weak var demoButton: UIButton!
    
    // MARK: Presenter
    var mainPresenter: MainPresenter!
    override var presenter: MainPresenter! {
        return mainPresenter
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.title = "Main"
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
extension MainViewController: MainPresenterView {
    
}

// MARK: - Actions
extension MainViewController {
    
    //
    @IBAction func demoButtonTapped() {
        self.presenter.detailAction()
    }
    
}

// MARK: - Methods
extension MainViewController {
    
}
