//
//  FlowCoordinator.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation
import UIKit

class FlowCoordinator {
    
    private let sender: BaseViewController
    
    init(from sender: BaseViewController) {
        self.sender = sender
    }
    
    //
    func pushDetailViewController(hero: Hero) {
        let detailViewController: DetailViewController = ServiceLocator.inject()
        detailViewController.detailPresenter.hero = hero
        self.sender.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
