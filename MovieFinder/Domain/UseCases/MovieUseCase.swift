//
//  MovieUseCase.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation
import RxSwift

protocol MovieUseCase {
    func movies(with query: String) -> Observable<Movie>
    func movieDetail(by id: String) -> Observable<MovieItem>
}
