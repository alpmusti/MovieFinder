//
//  HomeScreenRouter.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import UIKit

protocol MovieSearchRouter {
    func toDetail(with movie: MovieItem)
}

class MovieSearchNavigator: MovieSearchRouter {
    private let navigationController: UINavigationController
    private let networkUseCaseProvider: NetworkUseCaseProvider
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        networkUseCaseProvider = NetworkUseCaseProvider()
    }
    
    func toDetail(with movieItem: MovieItem) {
        let vc = MovieDetailViewController.instantiateViewController()
        let router = MovieDetailNavigator(navigationController: navigationController)
        vc.viewModel = MovieDetailViewModel(useCase: networkUseCaseProvider.makeMovieUseCase(), router: router)
        vc.imdbID = movieItem.imdbID ?? ""
        navigationController.pushViewController(vc, animated: true)
    }
}
