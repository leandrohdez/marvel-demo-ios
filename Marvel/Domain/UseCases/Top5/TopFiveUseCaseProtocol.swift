//
//  TopFiveUseCaseProtocol.swift
//  Marvel
//
//  Created by Leandro Hernandez on 14/4/22.
//

import Foundation

typealias TopFiveUseCaseResult = (Result<TopFiveUseCaseOutput, Error>)

protocol TopFiveUseCaseProtocol : AnyObject {
    func execute(completion: @escaping (TopFiveUseCaseResult) -> Void)
}
