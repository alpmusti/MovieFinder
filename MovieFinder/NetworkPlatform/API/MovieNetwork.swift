//
//  MovieNetwork.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import RxSwift

final class MoviesNetwork {
    private let network: Network<NETMovie>

    init(network: Network<NETMovie>) {
        self.network = network
    }

    func fetchMovies(with query: String) -> Observable<Movie> {
        return network.getItems(with: query).map({ model in model.asDomain() })
    }
}
