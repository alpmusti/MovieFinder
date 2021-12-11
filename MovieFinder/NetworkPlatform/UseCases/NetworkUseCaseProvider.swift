//
//  NetworkUseCaseProvider.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation

class NetworkUseCaseProvider: UseCaseProvider {
    func makeMovieUseCase() -> MovieUseCase {
        let networkProvider = NetworkProvider()
        let moviesNetwork = networkProvider.makeMoviesNetwork()
        let movieDetailsNetwork = networkProvider.makeMovieDetailNetwork()
        return NetworkMovieUseCase(network: moviesNetwork, detailNetwork: movieDetailsNetwork)
    }
}
