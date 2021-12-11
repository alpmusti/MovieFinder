//
//  NETMovie.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation

protocol DomainConvertible {
    associatedtype DomainType = Movie
    
    init(with domain: DomainType)
    
    func asDomain() -> DomainType
}

class NETMovie: Codable, DomainConvertible {
    var search: [NETMovieItem]?
    var totalResults, response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
    
    required init(with domain: Movie) {
        search = domain.search?.map({ domain in
            return NETMovieItem(with: domain)
        })
        totalResults = domain.totalResults
        response = domain.response
    }
}

extension NETMovie {
    func asDomain() -> Movie {
        return Movie(
            search: search?.map({ item in
                return item.asDomain()
            }),
            totalResults: totalResults,
            response: response
        )
    }
}
