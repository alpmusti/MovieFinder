//
//  HomeScreenViewController.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import UIKit
import RxCocoa
import RxSwift

class MovieSearchViewController: UIViewController, StoryboardInstantiable, Loadable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: MovieSearchViewModel?
    
    private let disposeBag = DisposeBag()
    private let cellIdentifier = "cell"
    private var items: BehaviorRelay<[MovieItem]> = BehaviorRelay(value: [])
    private var query: String = ""
    
    private var notFoundLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "No search results were found"
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initTableView()
        initSearchbar()
        title = "OMDB Search"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        notFoundLabel.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - 8, height: 50)
        notFoundLabel.center = view.center
    }
    
    private func showNotFoundLabel() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.view.addSubview(self.notFoundLabel)
        }
    }
    
    private func hideNotFoundLabel() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.notFoundLabel.removeFromSuperview()
        }
    }
    
    private func getMovie(with query: String) {
        self.query = query
        if query.isEmpty {
            hideNotFoundLabel()
            items.accept([])
        } else {
            showLoading()
            viewModel?.getMovies(with: query).subscribe(onNext: { [weak self] movie in
                self?.hideLoading()
                if let search = movie.search {
                    self?.items.accept(search)
                    self?.hideNotFoundLabel()
                } else {
                    self?.showNotFoundLabel()
                }
                
            }, onError: { [weak self] _ in
                self?.hideLoading()
            }).disposed(by: disposeBag)
        }
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func initSearchbar() {
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.getMovie(with: query)
            }).disposed(by: disposeBag)
    }
    
    private func initTableView() {
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        items.bind(to: tableView.rx.items) { [unowned self] tableView, data, element in
            if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? MovieTableViewCell {
                cell.bind(with: element)
                return cell
            }
            return UITableViewCell()
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            self?.viewModel?.gotoMovieDetail(with: self?.items.value[indexPath.row])
        }.disposed(by: disposeBag)
    }
}
