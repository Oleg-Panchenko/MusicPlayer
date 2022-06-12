//
//  UIVIewController + Storyboard.swift
//  IMusic
//
//  Created by Panchenko Oleg on 31.05.2022.
//

import UIKit

extension UIViewController {
    
    class func loadFromStroryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard!")
        }
    }
}

