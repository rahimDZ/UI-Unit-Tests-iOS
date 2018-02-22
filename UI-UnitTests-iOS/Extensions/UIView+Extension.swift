//
//  UIView+Extension.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 22/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {}

extension UIView
{
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return UIColor.clear
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
