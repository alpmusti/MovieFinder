//
//  FirebaseService.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation
import FirebaseRemoteConfig
import FirebaseAnalytics
import RxSwift

class FirebaseService {
    static let shared = FirebaseService()
    private let remoteConfig: RemoteConfig
    
    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
    }
    
    func fetchAndActivateRemoteConfig() -> Observable<RemoteConfigFetchStatus> {
        return Observable<RemoteConfigFetchStatus>.create { [weak self] observer in
            self?.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { status, error in
                guard let error = error else {
                    if status == .success {
                        self?.remoteConfig.activate()
                        observer.onNext(status)
                        observer.onCompleted()
                    }
                    return
                }
                observer.onError(error)
            })
            return Disposables.create()
        }
    }
    
    func fetchRemoteConfig(for key: String, defaultValue: String = "") -> Observable<String> {
        return Observable<String>.create { [unowned self] observer in
            self.fetchAndActivateRemoteConfig().subscribe { _ in
                observer.onNext(remoteConfig[key].stringValue ?? defaultValue)
                observer.onCompleted()
            }
        }
    }
    
    func logEvent(with eventName: String, and parameters: [String: Any]? = [:]) {
        Analytics.logEvent(eventName, parameters: parameters)
    }
}
