//
//  UIViewController+Extensions.swift
//  UI-UnitTests-iOS
//
//  Created by Abderrahim BENMAKHLOUF on 11/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

extension UIViewController
{
    class func fromStoryboard<T: UIViewController>(named storyboardName: String) -> T? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: T.self))
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T
        return vc
    }
}
