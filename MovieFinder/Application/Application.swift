//
//  Application.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import UIKit

class Application {
    static let shared = Application()
    
    private init() {}
    
    func configureMainInterface(in windowScene: UIWindowScene) -> UIWindow {
        let navigationController = UINavigationController()
        let navigator = SplashScreenNavigator(navigationController: navigationController)
        
        let window =  UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController

        navigator.toSplash()
        
        return window
    }
}
