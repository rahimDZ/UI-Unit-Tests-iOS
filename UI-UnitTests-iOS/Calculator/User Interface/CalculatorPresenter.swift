//
//  CalculatorPresenter.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 22/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

class CalculatorPresenter
{
    weak var view: CalculatorPresenterOutput? = nil
    var interactor: CalculatorInteractorInput

    init(interactor: CalculatorInteractorInput) {
        self.interactor = interactor
    }
}

// MARK: - Presenter Input

extension CalculatorPresenter: CalculatorPresenterInput
{
    func userDidSelectNumber(_ number: Int) {
        interactor.get(number: number)
    }
    
    func additionButtonDidTouchUpInside() {
        interactor.add()
    }
    
    func resetButtonDidTouchUpInside() {
        interactor.reset()
    }
    
    func equalButtonDidTouchUpInside() {
        interactor.equal()
    }
    
    func confirmResetDidSelectedOnPopup() {
        interactor.confirmReset()
    }
}

// MARK: - Interactor Output

extension CalculatorPresenter: CalculatorInteractorOutput
{
    func updateNumber(_ number: Int) {
        view?.display("\(number)")
    }
    
    func showConfirmationResetPopupAlert() {
        view?.displayConfirmationResetPopupAlert(title: "Alert", message: "Do you really want to reset your input?", confirmationTitle: "OK", cancelTitle: "Cancel")
    }
    
    func showResult(_ result: Int) {
        view?.display("\(result)")
    }
    
    func showReset() {
        view?.display("0")
    }
}
