//
//  MovieDetaiNetwork.swift
//  MovieFinder
//
//  Created by alpmusti on 10.12.2021.
//

import Foundation
import RxSwift

class MovieDetailNetwork {
    private let network: Network<NETMovieItem>
    
    init(network: Network<NETMovieItem>) {
        self.network = network
    }
    
    func fetchMovie(by imdbID: String) -> Observable<MovieItem> {
        return network.getItem(by: imdbID).map({ model in model.asDomain() })
    }
}
