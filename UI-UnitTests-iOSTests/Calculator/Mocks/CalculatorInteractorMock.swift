//
//  CalculatorInteractorMock.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 22/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

@testable import UIUnitTestsIOS

class CalculatorInteractorMock
{
    weak var output: CalculatorInteractorOutput? = nil
    
    private var cumul: String = ""
    private var number1: Int? = nil
    private var number2: Int? = nil
    private var result: Int = 0
    private var isAdditioning = false
    
    init() { }
}

// MARK: - Interactor Input

extension CalculatorInteractorMock: CalculatorInteractorInput
{
    func get(number: Int) {
        cumul += "\(number)"
        result = Int(cumul) ?? 0
        output?.updateNumber(result)
    }
    
    func add() {
        isAdditioning = true
        number1 = result
        cumul = ""
    }
    
    func confirmReset() {
        cumul = ""
        result = 0
        number1 = nil
        number2 = nil
        isAdditioning = false
        output?.showReset()
    }
    
    func reset() {
        output?.showConfirmationResetPopupAlert()
    }
    
    func equal() {
        if result > 0 && isAdditioning == false {
            result += number2 ?? 0
        } else {
            number2 = Int(cumul)
            if let number1 = number1, let number2 = number2 {
                isAdditioning = false
                result = number1 + number2
            }
        }
        output?.showResult(result)
    }
}
