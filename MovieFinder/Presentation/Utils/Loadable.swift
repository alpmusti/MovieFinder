//
//  Loadable.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import UIKit

private var loadingView: UIView?

public protocol Loadable {}

public extension Loadable where Self: UIViewController {
    func showLoading() {
        let spinnerView = UIView.init(frame: view.bounds)
        let ai = UIActivityIndicatorView(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            loadingView?.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
                
        loadingView = spinnerView
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            loadingView?.removeFromSuperview()
        }
    }
}
