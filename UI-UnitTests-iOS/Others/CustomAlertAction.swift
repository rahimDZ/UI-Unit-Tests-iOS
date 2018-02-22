//
//  CustomAlertAction.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 22/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

public protocol CustomAlertActionInput: class
{
    func actionWithTitle(_ title: String?, style: UIAlertActionStyle, handler: ((_ alertAction: UIAlertAction) -> Void)?) -> UIAlertAction
}

public class CustomAlertAction: UIAlertAction, CustomAlertActionInput
{
    public func actionWithTitle(_ title: String?, style: UIAlertActionStyle, handler: ((_ alertAction: UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}
