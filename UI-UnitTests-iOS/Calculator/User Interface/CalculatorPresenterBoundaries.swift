//
//  CalculatorPresenterBoundaries.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 22/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

protocol CalculatorPresenterInput: class
{
    func userDidSelectNumber(_ number: Int)
    func additionButtonDidTouchUpInside()
    func resetButtonDidTouchUpInside()
    func equalButtonDidTouchUpInside()
    func confirmResetDidSelectedOnPopup()
}

protocol CalculatorPresenterOutput: class
{
    func display(_ result: String)
    func displayConfirmationResetPopupAlert(title: String, message: String, confirmationTitle: String, cancelTitle: String)
}
