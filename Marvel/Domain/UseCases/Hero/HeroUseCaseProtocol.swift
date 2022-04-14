//
//  HeroUseCaseProtocol.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation

typealias HeroUseCaseResult = (Result<HeroUseCaseOutput, Error>)

protocol HeroUseCaseProtocol : AnyObject {
    func execute(input: HeroUseCaseInput, completion: @escaping (HeroUseCaseResult) -> Void)
}
