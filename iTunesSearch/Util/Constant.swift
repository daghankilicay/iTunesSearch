//
//  Constant.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 19.01.2021.
//

import Foundation

final class Constant{
    static let logo = "iTunesLogo"
    static let baseUrl = "https://itunes.apple.com/search?"
    static let term = "term="
    static let entity = "&entity="
    static let offset = "&offset="
    static let limit = "&limit="
}

enum ResultType: String {
    case movie
    case musicVideo
    case software
    case ebook

    var type: String {
        switch self {
        case .movie: return "movie"
        case .musicVideo: return "musicVideo"
        case .software: return "software"
        case .ebook: return "ebook"
        }
    }
}
