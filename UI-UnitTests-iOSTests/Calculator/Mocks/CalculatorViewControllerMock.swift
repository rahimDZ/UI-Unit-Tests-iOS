//
//  CalculatorViewControllerMock.swift
//  UI-UnitTests-iOSTests
//
//  Created by Abderrahim BENMAKHLOUF on 22/01/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

@testable import UIUnitTestsIOS

class CalculatorViewControllerMock: CalculatorViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initPresenter() -> CalculatorPresenterInput {
        let interactor = CalculatorInteractorMock()
        let presenter = CalculatorPresenter(interactor: interactor)
        interactor.output = presenter
        presenter.view = self
        return presenter
    }
}
