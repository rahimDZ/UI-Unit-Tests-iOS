//
//  CustomAlertActionMock.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 24/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

@testable import UIUnitTestsIOS

public class CustomAlertActionMock: UIAlertAction, CustomAlertActionInput
{
    public func actionWithTitle(_ title: String?, style: UIAlertActionStyle, handler: ((_ alertAction: UIAlertAction) -> Void)?) -> UIAlertAction {
        return AlertActionMock(title: title, style: style, handler: handler)
    }
}

// This class was inspired by this link : http://swiftandpainless.com/how-to-test-uialertcontroller-in-swift/
class AlertActionMock: UIAlertAction {
    
    // MARK: - Property
    
    typealias Handler = ((UIAlertAction) -> Void)
    var handler: Handler?
    var _title: String?
    var _style: UIAlertActionStyle
    
    // MARK: - Lifecycle
    
    convenience init(title: String?, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) {
        self.init()
        _title = title
        _style = style
        self.handler = handler
    }
    
    override init() {
        _style = .default
        super.init()
    }
}

