//
//  SplashScreenViewController.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import UIKit
import RxSwift
import RxCocoa
import Reachability

class SplashScreenViewController: UIViewController, StoryboardInstantiable, Alertable, Loadable {
    
    @IBOutlet weak var splashTextLabel: UILabel!
    
    var viewModel: SplashScreenViewModel?
    private let disposeBag: DisposeBag = DisposeBag()
    private var reachability: Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkReachability()
    }
    
    private func checkReachability() {
        let reachability = try? Reachability()
        self.reachability = reachability
        reachability?.whenReachable = { [weak self] _ in
            self?.setupLabel()
        }
        
        reachability?.whenUnreachable = { [weak self] _ in
            self?.setDefaultText()
            self?.showAlert(message: "You are seems to be offline. Please check your connection and try again later.")
        }
        
        try? reachability?.startNotifier()
    }
    
    private func setupLabel() {
        showLoading()
        viewModel?.getInitialText()
            .subscribe(onNext: { [weak self] text in
                self?.hideLoading()
                self?.splashTextLabel.text = text
                self?.gotoHomeScreen()
            }, onError: { [weak self] _ in
                self?.hideLoading()
                self?.setDefaultText()
                self?.gotoHomeScreen()
            })
            .disposed(by: disposeBag)
    }
    
    private func gotoHomeScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.viewModel?.gotoHomeScreen()
        }
    }
    
    private func setDefaultText() {
        DispatchQueue.main.async { [weak self] in
            self?.splashTextLabel.text = "Loodos"
        }
    }
    
    deinit {
        reachability?.stopNotifier()
    }
}
