//
//  StoryboardInstantiable.swift
//  MovieFinder
//
//  Created by alpmusti on 9.12.2021.
//

import UIKit

protocol StoryboardInstantiable {
    static func instantiateViewController(_ storyboardName: String?) -> Self
}

extension StoryboardInstantiable where Self: UIViewController {
    
    static func instantiateViewController(_ storyboardName: String? = nil) -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        
        // load our storyboard
        let storyboard = UIStoryboard(name: storyboardName ?? "Main", bundle: Bundle.main)
        
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
