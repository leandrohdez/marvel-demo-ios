//
//  BasePresenterView.swift
//  Marvel
//
//  Created by Leandro Hernandez on 17/3/22.
//

import Foundation

protocol BasePresenterView: AnyObject {
    
    func startLoading()
    
    func stopLoading()
    
    func showMessage(title: String, text: String)
    
    func showMessage(title: String, text: String, buttonTitle: String)
    
    func showMessage(title: String, text: String, buttonTitle: String, buttonPressed: @escaping (() -> Void))
    
}

extension BasePresenterView {
    
    func showMessage(title: String, text: String) { }
    
    func showMessage(title: String, text: String, buttonTitle: String) { }
    
    func showMessage(title: String, text: String, buttonTitle: String, buttonPressed: @escaping (() -> Void)) { }
    
}
