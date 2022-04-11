//
//  PaginationRequest.swift
//  Marvel
//
//  Created by Leandro Hernandez on 11/4/22.
//

import Foundation

class PaginationRequest {

    var offset: Int
    
    var limit: Int
    
    //
    init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
}
