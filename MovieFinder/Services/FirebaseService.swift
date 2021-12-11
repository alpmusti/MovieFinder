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
    private var isFetched: Bool = false
    
    private init() {}
    
    func fetchAndActivateRemoteConfig() -> Observable<RemoteConfigFetchAndActivateStatus> {
        if isFetched {
            return Observable.of(.successFetchedFromRemote)
        }
        let remoteConfig = RemoteConfig.remoteConfig()
        return Observable<RemoteConfigFetchAndActivateStatus>.create { observer in
            remoteConfig.fetchAndActivate { [weak self] (status, error) in
                guard let error = error else {
                    self?.isFetched = status == .successFetchedFromRemote
                    observer.onNext(status)
                    observer.onCompleted()
                    return
                }
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func fetchRemoteString(by key: String, defaultValue: String = "") -> Observable<String> {
        return Observable<String>.create { [unowned self] observer in
            self.fetchAndActivateRemoteConfig().subscribe { _ in
                observer.onNext(RemoteConfig.remoteConfig()[key].stringValue ?? defaultValue)
                observer.onCompleted()
            }
        }
    }
    
    func logEvent(with eventName: String, and parameters: [String: Any]? = [:]) {
        Analytics.logEvent(eventName, parameters: parameters)
    }
}
