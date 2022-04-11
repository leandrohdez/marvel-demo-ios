//
//  BaseViewController.swift
//  Marvel
//
//  Created by Leandro Hernandez on 17/3/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    // Presenter
    var presenter: BasePresenter! {
        return nil
    }
    
    // Handlers
    var viewDidLoadHandler: ((_ viewController: BaseViewController) -> Void)?
    
    var viewWillAppearHandler: ((_ viewController: BaseViewController) -> Void)?
    
    var viewDidAppearHandler: ((_ viewController: BaseViewController) -> Void)?
    
    var viewWillDisappearHandler: ((_ viewController: BaseViewController) -> Void)?
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        if self.viewDidLoadHandler != nil { self.viewDidLoadHandler!(self) }
        
        // Load configuration data
        // For example: Firebase RemoteConfig
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
        
        if self.viewWillAppearHandler != nil { self.viewWillAppearHandler!(self) }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.viewDidAppear()
        
        if self.viewDidAppearHandler != nil { self.viewDidAppearHandler!(self) }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.viewWillDisappear()
        
        if self.viewWillDisappearHandler != nil { self.viewWillDisappearHandler!(self) }
    }
    
    func startLoading() { }
    
    func stopLoading() { }

    // MARK: Alerts Methods
    func showMessage(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showMessage(title: String, text: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showMessage(title: String, text: String, buttonTitle: String, buttonPressed: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            buttonPressed()
        }))
        self.present(alert, animated: true)
    }
    
    func showMessage(title: String, text: String, button1Title: String, button1Pressed: (() -> Void)? = nil, button2Title: String, button2Pressed: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button1Title, style: .default, handler: { _ in
            button1Pressed?()
        }))
        alert.addAction(UIAlertAction(title: button2Title, style: .default, handler: { _ in
            button2Pressed?()
        }))
        self.present(alert, animated: true)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
