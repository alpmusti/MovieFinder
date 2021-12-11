//
//  MovieDetailNavigator.swift
//  MovieFinder
//
//  Created by alpmusti on 10.12.2021.
//

import UIKit

protocol MovieDetailRouter {}

class MovieDetailNavigator: MovieDetailRouter {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
