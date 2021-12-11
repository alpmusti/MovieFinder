//
//  MovieTableViewCell.swift
//  MovieFinder
//
//  Created by alpmusti on 10.12.2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    func bind(with movieItem: MovieItem) {
        titleLabel.text = movieItem.title
        yearLabel.text = movieItem.year
        posterImageView.loadImage(from: movieItem.poster)
        accessoryType = .disclosureIndicator
    }
    
}
