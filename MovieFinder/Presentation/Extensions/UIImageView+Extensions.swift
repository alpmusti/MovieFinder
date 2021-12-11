//
//  UIImageView+Extensions.swift
//  MovieFinder
//
//  Created by alpmusti on 10.12.2021.
//

import UIKit
import Alamofire

extension UIImageView {
    func loadImage(from url: String?) {
        guard let urlString = url, let url = URL(string: urlString) else {
            return
        }
        
        AF.request(url).responseData { response in
            if let data = response.data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
