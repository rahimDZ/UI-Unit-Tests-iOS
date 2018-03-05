//
//  UIColor+Extensions.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

extension UIColor
{
   static var happyFace: UIColor {
        return UIColor(red: 0.0, green: 249.0/255.0, blue: 0.0, alpha: 1.0)
    }

    static var sadFace: UIColor {
        return UIColor(red: 0.0, green: 145.0/255.0, blue: 147.0/255.0, alpha: 1.0)
    }

    static var angryFace: UIColor {
        return UIColor(red: 255.0/255.0, green: 38.0/255.0, blue: 0.0, alpha: 1.0)
    }

    static var surprisedFace: UIColor {
        return UIColor(red: 255.0/255.0, green: 212.0/255.0, blue: 121.0/255.0, alpha: 1.0)
    }

    static var errorFace: UIColor {
        return .darkGray
    }
}
