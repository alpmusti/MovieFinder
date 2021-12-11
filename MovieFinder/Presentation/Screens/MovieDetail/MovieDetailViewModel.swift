//
//  MovieDetaiViewModel.swift
//  MovieFinder
//
//  Created by alpmusti on 10.12.2021.
//

import Foundation
import RxSwift

class MovieDetailViewModel {
    private let useCase: MovieUseCase
    private let router: MovieDetailRouter
    
    init(useCase: MovieUseCase, router: MovieDetailRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func getMovieDetail(by imdbID: String) -> Observable<MovieItem> {
        return useCase.movieDetail(by: imdbID)
    }
}
