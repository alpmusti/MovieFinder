//
//  NetworkMovieUseCase.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation
import RxSwift

class NetworkMovieUseCase: MovieUseCase {
    private let network: MoviesNetwork
    private let detailNetwork: MovieDetailNetwork
    
    init(network: MoviesNetwork, detailNetwork: MovieDetailNetwork) {
        self.network = network
        self.detailNetwork = detailNetwork
    }
    
    func movies(with query: String) -> Observable<Movie> {
        return network.fetchMovies(with: query)
    }
    
    func movieDetail(by imdbId: String) -> Observable<MovieItem> {
        return detailNetwork.fetchMovie(by: imdbId)
    }
}
