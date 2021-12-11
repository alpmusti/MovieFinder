//
//  UseCaseProvider.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation

protocol UseCaseProvider {
    func makeMovieUseCase() -> MovieUseCase
}
