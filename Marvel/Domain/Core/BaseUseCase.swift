//
//  BaseUseCase.swift
//  Marvel
//
//  Created by Leandro Hernandez on 17/3/22.
//

import Foundation

class BaseUseCase {
    
    var beginHandle: (() -> Void)?
    
    var endHandle: ((_ result: UseCaseResult) -> Void)?
    
    func execute() {
        DispatchQueue.main.async {
            self.beginHandle?()
        }
    }
    
    func finish(caseResult: UseCaseResult) {
        DispatchQueue.main.async {
            self.endHandle?(caseResult)
        }
    }
    
}
