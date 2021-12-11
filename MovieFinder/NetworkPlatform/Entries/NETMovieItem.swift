//
//  NETMovieItem.swift
//  MovieFinder
//
//  Created by alpmusti on 10.12.2021.
//

import Foundation

protocol MovieDetailDomainConvertible {
    associatedtype DomainType = MovieItem
    
    init(with domain: DomainType)
    
    func asDomain() -> DomainType
}

class NETMovieItem: Codable, MovieDetailDomainConvertible {
    let title, year, genre, actors: String?
    let plot, awards, runtime: String?
    let poster: String?
    let imdbRating, imdbID, type: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case genre = "Genre"
        case actors = "Actors"
        case plot = "Plot"
        case awards = "Awards"
        case poster = "Poster"
        case runtime = "Runtime"
        case imdbRating, imdbID
        case type = "Type"
    }
    
    required init(with domain: MovieItem) {
        self.title = domain.title
        self.year = domain.year
        self.genre = domain.genre
        self.actors = domain.actors
        self.plot = domain.plot
        self.awards = domain.awards
        self.poster = domain.poster
        self.imdbID = domain.imdbID
        self.imdbRating  = domain.imdbRating
        self.runtime = domain.runtime
        self.type = domain.type
    }
    
    func asDomain() -> MovieItem {
        return MovieItem(title: title,
                         year: year,
                         runtime: runtime,
                         genre: genre,
                         actors: actors,
                         plot: plot,
                         awards: awards,
                         poster: poster,
                         imdbRating: imdbRating,
                         imdbID: imdbID,
                         type: type)
    }
}
