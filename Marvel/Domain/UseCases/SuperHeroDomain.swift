//
//  SuperHeroDomain.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

class SuperHeroDomain {
    
    static let UseCases = SuperHeroDomain()
 
    // Get list of heroes available
    func heroes(pageIndex: Int, pageLength: Int, completion: @escaping (_ result: HeroesCaseResult) -> Void) {
        let useCase = HeroesUseCase(pageIndex: pageIndex, pageLength: pageLength)
        useCase.endHandle = { (resultCase) in
            if let result = resultCase as? HeroesCaseResult {
                completion(result)
            }
        }
        useCase.execute()
    }
    
}
