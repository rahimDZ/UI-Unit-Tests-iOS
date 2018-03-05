//
//  CalculatorInteractor.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 22/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

fileprivate enum CalculationOperator
{
    case addition
    case none
}

class CalculatorInteractor
{
    private var calculationOperator: CalculationOperator = .none {
        didSet {
            if calculationOperator != .none {
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
        }
    }
    weak var output: CalculatorInteractorOutput? = nil
    
    private var cumul: String = "" {
        didSet {
            if let nbr = Int(cumul) {
                output?.updateNumber(nbr)
            } else {
                if !cumul.isEmpty {
                    cumul.removeLast()
                }
            }
        }
    }
    private var number1: Int? = nil
    private var number2: Int? = nil
    private var result: Int {
        if let number1 = number1, let number2 = number2 {
            switch calculationOperator
            {
            case .addition: return add(number1, with: number2)
            case .none: return 0
            }
        } else {
            return number1 ?? 0
        }
    }
    private var isEqualDone = false
    
    init() { }
    
    private func add(_ number1: Int, with number2: Int) -> Int {
        if number1.addingReportingOverflow(number2).overflow == true {
            return Int.max
        } else {
            return number1 + number2
        }
    }
}

// MARK: - Interactor Input

extension CalculatorInteractor: CalculatorInteractorInput
{
    func get(number: Int) {
        cumul += "\(number)"
    }
    
    func add() {
        calculationOperator = .addition
    }
    
    func confirmReset() {
        cumul = ""
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
        if result == Int.max {
            output?.showResultOverflow()
            return
        }
        output?.showResult(result)
        number1 = result
    }
}
