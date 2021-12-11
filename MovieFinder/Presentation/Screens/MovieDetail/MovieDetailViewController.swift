//
//  MovieDetailViewController.swift
//  MovieFinder
//
//  Created by alpmusti on 10.12.2021.
//

import UIKit
import RxSwift

class MovieDetailViewController: UIViewController, StoryboardInstantiable, Loadable {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var plotTextView: UITextView!
    
    var viewModel: MovieDetailViewModel?
    var imdbID: String = ""
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetails(by: imdbID)
    }

    private func logScreenView(with movie: MovieItem) {
        FirebaseService.shared.logEvent(with: "view_movie_detail", and: ["imdbID": movie.imdbID ?? "", "title": movie.title ?? ""])
    }
    
    private func getMovieDetails(by id: String) {
        showLoading()
        viewModel?.getMovieDetail(by: id).subscribe(onNext: { [weak self] movieItem in
            self?.hideLoading()
            self?.setupUI(with: movieItem)
            self?.logScreenView(with: movieItem)
        }, onError: { [weak self] _ in
            self?.hideLoading()
        }).disposed(by: disposeBag)
    }
    
    private func setupUI(with movieItem: MovieItem) {
        DispatchQueue.main.async { [weak self] in
            self?.posterImageView.loadImage(from: movieItem.poster)
            self?.plotTextView.text = movieItem.plot
            self?.yearLabel.text = movieItem.year
            self?.actorsLabel.text = movieItem.actors
            self?.genreLabel.text = movieItem.genre
            self?.runtimeLabel.text = movieItem.runtime
            self?.typeLabel.text = movieItem.type
            if let rating = movieItem.imdbRating {
                self?.ratingLabel.text = "\(rating)/10"
            } else {
                self?.ratingLabel.isHidden = true
            }
            self?.title = movieItem.title
        }
    }
}
