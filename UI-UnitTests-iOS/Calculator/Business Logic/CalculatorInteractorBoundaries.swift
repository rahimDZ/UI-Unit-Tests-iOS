//
//  CalculatorInteractorBoundaries.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 22/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

protocol CalculatorInteractorInput: class
{
    func get(number: Int)
    func add()
    func reset()
    func confirmReset()
    func equal()
}

protocol CalculatorInteractorOutput: class
{
    func updateNumber(_ number: Int)
    func showConfirmationResetPopupAlert()
    func showResult(_ result: Int)
    func showResultOverflow()
    func showReset()
}
