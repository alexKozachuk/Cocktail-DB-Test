//
//  Storyboard.swift
//  Cocktail DB
//
//  Created by Sasha on 09/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main
    
    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue.capitalized, bundle: nil)
    }
    
    func viewController<T: UIViewController>(viewControllerTypes: T.Type) -> T {
        let storyboardID = String(describing: viewControllerTypes)
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
}

extension UIViewController {
    
    static func instantiate<T: UIViewController>(from storyboard: Storyboard) -> T {
        return storyboard.viewController(viewControllerTypes: T.self)
    }
    
}
