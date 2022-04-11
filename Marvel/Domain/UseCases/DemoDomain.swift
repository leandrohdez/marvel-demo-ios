//
//  DemoDomain.swift
//  Marvel
//
//  Created by Leandro Hernandez on 17/3/22.
//

import Foundation

class SuperHeroDomain {
    
    static let UseCases = SuperHeroDomain()
 
    //
    func demo(completion: @escaping (_ result: DemoCaseResult) -> Void) {
        let useCase = DemoUseCase()
        useCase.endHandle = { (resultCase) in
            if let result = resultCase as? DemoCaseResult {
                completion(result)
            }
        }
        useCase.execute()
    }
    
}
