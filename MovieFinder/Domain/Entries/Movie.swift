//
//  Movie.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    var search: [MovieItem]?
    var totalResults, response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - MovieItem
struct MovieItem: Codable {
    let title, year, runtime, genre: String?
    let actors, plot, awards: String?
    let poster: String?
    let imdbRating, imdbID, type: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case runtime = "Runtime"
        case genre = "Genre"
        case actors = "Actors"
        case plot = "Plot"
        case awards = "Awards"
        case poster = "Poster"
        case imdbRating, imdbID
        case type = "Type"
    }
}
