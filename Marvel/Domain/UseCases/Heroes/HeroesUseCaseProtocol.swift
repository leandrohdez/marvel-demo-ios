//
//  HeroesUseCaseProtocol.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation

typealias HeroesUseCaseResult = (Result<HeroesUseCaseOutput, Error>)

protocol HeroesUseCaseProtocol : AnyObject {
    func execute(input: HeroesUseCaseInput, completion: @escaping (HeroesUseCaseResult) -> Void)
}
