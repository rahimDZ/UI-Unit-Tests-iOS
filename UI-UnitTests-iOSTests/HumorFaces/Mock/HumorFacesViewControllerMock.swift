//
//  HumorFacesViewControllerMock.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

@testable import UIUnitTestsIOS

public enum NetworkState
{
    case success
    case successWithNoData
    case serverError
    case networkError
}

class HumorFacesViewControllerMock: HumorFacesViewController {

    // MARK: - Property
    
    private var networkState: NetworkState = .success
    private var humorFaceType: HumorFaceType = .happy
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
    override func initHumorFacesPresenter() -> HumorFacesPresenterInput? {
        let interactor = HumorFacesInteractorMock(networkState: networkState, humorFaceType: humorFaceType)
        let presenter = HumorFacesPresenter(interactor: interactor)
        interactor.output = presenter
        presenter.view = self
        return presenter
    }
    
    override func dismissAlertViewController() {
        didDismissAlertViewController = true
        super.dismissAlertViewController()
    }
    
    // MARK: - Helper Methods
    
    func updateNetworkState(_ state: NetworkState) {
        networkState = state
    }

    func updateHumorFaceType(_ type: HumorFaceType) {
        humorFaceType = type
        initHumorFacesPresenter()
    }
}
