//
//  SplahScreenViewModel.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import UIKit
import RxSwift

class SplashScreenViewModel {
    private let router: SplashScreenRouter
    private let splashRemoteConfigKey = "SplashText"
    
    init(router: SplashScreenRouter) {
        self.router = router
    }
    
    func getInitialText() -> Observable<String> {
        return FirebaseService.shared.fetchRemoteString(by: splashRemoteConfigKey, defaultValue: "Loodos")
    }
    
    func gotoHomeScreen() {
        router.toHome()
    }
}
