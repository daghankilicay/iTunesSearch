//
//  Result.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 20.01.2021.
//

import Foundation

struct Content: Decodable {
    
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackName : String?
    let releaseDate: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case artworkUrl100 = "artworkUrl100"
        case collectionPrice = "collectionPrice"
        case trackName = "trackName"
        case releaseDate = "releaseDate"
        case description = "longDescription"
    }
}
