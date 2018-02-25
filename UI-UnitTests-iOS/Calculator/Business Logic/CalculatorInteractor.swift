//
//  CalculatorInteractor.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 22/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

class CalculatorInteractor
{
    weak var output: CalculatorInteractorOutput? = nil
    
    private var cumul: String = ""
    private var number1: Int? = nil
    private var number2: Int? = nil
    private var result: Int = 0
    private var isEqualDone = false
    
    init() { }
}

// MARK: - Interactor Input

extension CalculatorInteractor: CalculatorInteractorInput
{
    func get(number: Int) {
        cumul += "\(number)"
        if let nbr = Int(cumul) {
            output?.updateNumber(nbr)
        } else {
            cumul.removeLast()
        }
    }
    
    func add() {
        number2 = nil
        if number1 == nil {
            number1 = Int(cumul)
        } else {
            number2 = Int(cumul)
        }
        cumul = ""
        if number1 != nil && number2 != nil {
            equal()
        }
    }
    
    func confirmReset() {
        cumul = ""
        result = 0
        number1 = nil
        number2 = nil
        isEqualDone = false
        output?.showReset()
    }
    
    func reset() {
        output?.showConfirmationResetPopupAlert()
    }
    
    func equal() {
        if number1 == nil && !cumul.isEmpty {
            number1 = Int(cumul)
            cumul = ""
        }
        if number1 != nil && (number2 == nil || !cumul.isEmpty) {
            number2 = Int(cumul)
            cumul = ""
        }
        if let number1 = number1, let number2 = number2 {
            if number1.addingReportingOverflow(number2).overflow == true {
                result = Int.max
                self.number1 = result
                output?.showResultOverflow()
                return
            } else {
                result = number1 + number2
            }
        } else {
            result = number1 ?? 0
        }
        output?.showResult(result)
        self.number1 = result
    }
}
