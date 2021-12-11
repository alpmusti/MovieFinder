//
//  SplashScreenRouter.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation
import UIKit

protocol SplashScreenRouter {
    func toSplash()
    func toHome()
}

class SplashScreenNavigator: SplashScreenRouter {
    private let navigationController: UINavigationController
    private let useCaseProvider: UseCaseProvider
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        useCaseProvider = NetworkUseCaseProvider()
    }
    
    func toSplash() {
        let vc = SplashScreenViewController.instantiateViewController()
        vc.viewModel = SplashScreenViewModel(router: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toHome() {
        let vc = MovieSearchViewController.instantiateViewController()
        let router = MovieSearchNavigator(navigationController: navigationController)
        vc.viewModel = MovieSearchViewModel(useCase: useCaseProvider.makeMovieUseCase(), router: router)
        navigationController.pushViewController(vc, animated: false)
        navigationController.viewControllers.remove(at: 0)
    }
}
