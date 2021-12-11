//
//  Network.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import Foundation
import RxAlamofire
import RxSwift

class Network<T: Decodable> {
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    func getItems(with query: String) -> Observable<T> {
        let absolutePath = "\(endPoint)&s=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
        return RxAlamofire
            .data(.get, absolutePath)
            .observe(on: scheduler)
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }
    
    func getItem(by id: String) -> Observable<T> {
        let absolutePath = "\(endPoint)&i=\(id)"
        return RxAlamofire
            .data(.get, absolutePath)
            .observe(on: scheduler)
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }
}
