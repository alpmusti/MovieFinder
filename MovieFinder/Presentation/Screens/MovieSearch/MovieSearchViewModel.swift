//
//  HomeScreenViewModel.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation
import RxSwift

class MovieSearchViewModel {
    private let useCase: MovieUseCase
    private let router: MovieSearchRouter
    
    init(useCase: MovieUseCase, router: MovieSearchRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func getMovies(with query: String) -> Observable<Movie> {
        return useCase.movies(with: query)
    }
    
    func gotoMovieDetail(with movie: MovieItem?) {
        if let movieItem = movie {
            router.toDetail(with: movieItem)
        }
    }
}
