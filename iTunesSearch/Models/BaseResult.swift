//
//  BaseResponse.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 20.01.2021.
//

import Foundation

struct BaseResult : Decodable {
    let resultCount: Int
    let results : [Content]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case resultCount
    }
}
