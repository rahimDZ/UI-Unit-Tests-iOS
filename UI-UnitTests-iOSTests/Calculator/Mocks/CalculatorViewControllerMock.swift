//
//  CalculatorViewControllerMock.swift
//  UI-UnitTests-iOSTests
//
//  Created by Abderrahim BENMAKHLOUF on 22/01/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

@testable import UIUnitTestsIOS

// We inherit the CalculatorViewController to be able to access to all outlets and behaviors
class CalculatorViewControllerMock: CalculatorViewController {
    
    // MARK: - Property
    
    var didDismissAlertViewController: Bool = false
    
    // We override this customAlertAction to be able to programmatically click on its buttons
    override var customAlertAction: CustomAlertActionInput {
        return CustomAlertActionMock()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // We override this method to be able to mock the interactor which is the business logic part
    override func initPresenter() -> CalculatorPresenterInput {
        let interactor = CalculatorInteractorMock()
        let presenter = CalculatorPresenter(interactor: interactor)
        interactor.output = presenter
        presenter.view = self
        return presenter
    }
    
    override func dismissAlertViewController() {
        didDismissAlertViewController = true
        super.dismissAlertViewController()
    }
}
