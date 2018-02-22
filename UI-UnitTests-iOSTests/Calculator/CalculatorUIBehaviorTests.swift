//
//  CalculatorUIBehaviorTests.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 22/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import XCTest
import Quick
import Nimble
import UIKit

@testable import UIUnitTestsIOS

final class CalculatorUIBehaviorTests: QuickSpec {
    
    public var calculatorViewControllerMock: CalculatorViewControllerMock?
    var navigationController: UINavigationController?
    
    override func spec() {
        describe("GIVEN that I am on the Calculator Page") {
            var dashboardViewControllerMock: DashboardViewControllerMock?
            beforeEach {
                dashboardViewControllerMock = DashboardViewControllerMock.fromStoryboard(named: "DashboardMock")
                self.calculatorViewControllerMock = CalculatorViewControllerMock.fromStoryboard(named: "CalculatorMock")
                UIApplication.shared.keyWindow?.rootViewController = dashboardViewControllerMock
                dashboardViewControllerMock?.present(self.calculatorViewControllerMock!, animated: false, completion: nil)
            }
            context("WHEN I click on the close button") {
                beforeEach {
                    UIApplication.shared.sendAction((self.calculatorViewControllerMock?.closeButton?.action)!, to: self.calculatorViewControllerMock?.closeButton?.target, from: self.calculatorViewControllerMock?.closeButton, for: nil)
                }
                it("THEN I should go back to the dashboard page") {
                    expect(dashboardViewControllerMock?.presentedViewController).toEventually(beNil())
                    expect(self.calculatorViewControllerMock?.presentingViewController).toEventually(beNil())
                }
            }
            context("WHEN I click tap the number 4 and then the number 2") {
                beforeEach {
                    let numberFourButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 4 })?.first
                    let numberTwoButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 2 })?.first
                    numberFourButton?.sendActions(for: .touchUpInside)
                    numberTwoButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should displays the number 42 on the screen") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("42"))
                }
            }
            context("WHEN I calculate 2 plus 2 AND I click on equal") {
                beforeEach {
                    let numberTwoButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 2 })?.first
                    numberTwoButton?.sendActions(for: .touchUpInside)
                    self.calculatorViewControllerMock?.additionButton?.sendActions(for: .touchUpInside)
                    numberTwoButton?.sendActions(for: .touchUpInside)
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should equals displays 4") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("4"))
                }
            }
        }
    }
}

