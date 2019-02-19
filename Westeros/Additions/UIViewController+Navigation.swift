//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by Alexandre Freire on 04/02/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
