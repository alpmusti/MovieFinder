//
//  NetworkProvider.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "http://omdbapi.com/?apikey=f9790cef"
    }
    
    public func makeMoviesNetwork() -> MoviesNetwork {
        let network = Network<NETMovie>(apiEndpoint)
        return MoviesNetwork(network: network)
    }
    
    public func makeMovieDetailNetwork() -> MovieDetailNetwork {
        let network = Network<NETMovieItem>(apiEndpoint)
        return MovieDetailNetwork(network: network)
    }
}
