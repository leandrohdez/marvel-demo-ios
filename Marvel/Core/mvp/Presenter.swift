//
//  Presenter.swift
//  Marvel
//
//  Created by Leandro Hernandez on 17/3/22.
//

import Foundation

protocol Presenter {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
}

extension Presenter {
    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewDidAppear() { }
    func viewWillDisappear() { }
}

