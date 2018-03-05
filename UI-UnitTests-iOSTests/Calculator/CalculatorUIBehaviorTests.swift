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
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                UIApplication.shared.keyWindow?.rootViewController = dashboardViewControllerMock
                dashboardViewControllerMock?.present(self.calculatorViewControllerMock!, animated: false, completion: nil)
            }
            var presentedVC: CalculatorViewController? = nil
            context("WHEN I click on the close button") {
                beforeEach {
                    presentedVC = dashboardViewControllerMock?.presentedViewController as? CalculatorViewController
                    precondition(dashboardViewControllerMock?.presentedViewController != nil, "you must present the CalculatorViewController on the DashboardViewController")
                    UIApplication.shared.sendAction((presentedVC?.closeButton?.action)!, to: presentedVC?.closeButton?.target, from: presentedVC?.closeButton, for: nil)
                }
                it("THEN The Calculator Page is Dismissed AND I should go back to the dashboard page") {
                    expect(dashboardViewControllerMock?.presentedViewController).toEventually(beNil())
                    expect(presentedVC?.presentingViewController).toEventually(beNil())
                }
            }
            context("WHEN I tap the number 4 and then the number 2") {
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
        }
        describe("GIVEN I tap the number 1") {
            beforeEach {
                self.calculatorViewControllerMock = CalculatorViewControllerMock.fromStoryboard(named: "CalculatorMock")
                self.calculatorViewControllerMock?.view.layoutSubviews()
                let numberOneButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 1 })?.first
                numberOneButton?.sendActions(for: .touchUpInside)
            }
            context("WHEN I click on equal") {
                beforeEach {
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should displays the number 1 on the screen") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("1"))
                }
            }
            context("WHEN I click on equal twice") {
                beforeEach {
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should displays the number 1 on the screen") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("1"))
                }
            }
        }
        describe("GIVEN that I calculate 2 plus 2") {
            beforeEach {
                self.calculatorViewControllerMock = CalculatorViewControllerMock.fromStoryboard(named: "CalculatorMock")
                self.calculatorViewControllerMock?.view.layoutSubviews()
                let numberTwoButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 2 })?.first
                numberTwoButton?.sendActions(for: .touchUpInside)
                self.calculatorViewControllerMock?.additionButton?.sendActions(for: .touchUpInside)
                numberTwoButton?.sendActions(for: .touchUpInside)
            }
            context("WHEN I click on equal") {
                beforeEach {
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should displays 4") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("4"))
                }
            }
            context("WHEN I click on equal twice") {
                beforeEach {
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should equals displays 6") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("6"))
                }
            }
            context("WHEN I click again on the add button") {
                beforeEach {
                    self.calculatorViewControllerMock?.additionButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should displays 4") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("4"))
                }
            }
            context("WHEN I click again on the add button AND I add 3 to the result AND I click on equal again") {
                beforeEach {
                    self.calculatorViewControllerMock?.additionButton?.sendActions(for: .touchUpInside)
                    let numberThreeButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 3 })?.first
                    numberThreeButton?.sendActions(for: .touchUpInside)
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should displays 7") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("7"))
                }
            }
            context("WHEN I click on equal AND I add 3 to the result AND I click on equal again") {
                beforeEach {
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                    self.calculatorViewControllerMock?.additionButton?.sendActions(for: .touchUpInside)
                    let numberThreeButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 3 })?.first
                    numberThreeButton?.sendActions(for: .touchUpInside)
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should displays 7") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("7"))
                }
            }
            context("WHEN I click on equal AND I add 3 to the result AND I click on add button") {
                beforeEach {
                    self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                    self.calculatorViewControllerMock?.additionButton?.sendActions(for: .touchUpInside)
                    let numberThreeButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 3 })?.first
                    numberThreeButton?.sendActions(for: .touchUpInside)
                    self.calculatorViewControllerMock?.additionButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should displays 7") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("7"))
                }
            }
        }
        describe("GIVEN that I made some calculcation") {
            beforeEach {
                self.calculatorViewControllerMock = CalculatorViewControllerMock.fromStoryboard(named: "CalculatorMock")
                UIApplication.shared.keyWindow?.rootViewController = self.calculatorViewControllerMock
                let numberTwoButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 2 })?.first
                numberTwoButton?.sendActions(for: .touchUpInside)
                self.calculatorViewControllerMock?.additionButton?.sendActions(for: .touchUpInside)
                numberTwoButton?.sendActions(for: .touchUpInside)
                self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
            }
            context("WHEN I click on Cancel") {
                var alertController: UIAlertController? = nil
                beforeEach {
                    self.calculatorViewControllerMock?.cancelButton?.sendActions(for: .touchUpInside)
                    alertController = self.calculatorViewControllerMock?.presentedViewController as? UIAlertController
                }
                it("THEN it should display a popup to confirm the cancel of the result") {
                    expect(alertController).toNotEventually(beNil())
                }
                it("AND the popup title must be 'Alert'") {
                    expect(alertController?.title).to(equal("Alert"))
                }
                it("AND the popup message must be 'Do you really want to reset your input?'") {
                    expect(alertController?.message).to(equal("Do you really want to reset your input?"))
                }
                it("AND the popup confirmation title must be 'OK'") {
                    let okAction = alertController?.actions.last as? AlertActionMock
                    expect(okAction?._title).to(equal("OK"))
                    expect(okAction?._style).to(equal(UIAlertActionStyle.default))
                }
                it("AND the popup cancel title must be 'Cancel'") {
                    let cancelAction = alertController?.actions.first as? AlertActionMock
                    expect(cancelAction?._title).to(equal("Cancel"))
                    expect(cancelAction?._style).to(equal(UIAlertActionStyle.destructive))
                }
            }
        }
        describe("GIVEN that the result of my last calculation is 42, and the confirmation cancel alertPopup is displayed") {
            beforeEach {
                self.calculatorViewControllerMock = CalculatorViewControllerMock.fromStoryboard(named: "CalculatorMock")
                UIApplication.shared.keyWindow?.rootViewController = self.calculatorViewControllerMock
                let numberFourButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 4 })?.first
                let numberTwoButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 2 })?.first
                numberFourButton?.sendActions(for: .touchUpInside)
                numberTwoButton?.sendActions(for: .touchUpInside)
                self.calculatorViewControllerMock?.cancelButton?.sendActions(for: .touchUpInside)
            }
            context("WHEN I click on the Cancel alertPopup button") {
                var alertController: UIAlertController? = nil
                beforeEach {
                    alertController = self.calculatorViewControllerMock?.presentedViewController as? UIAlertController
                    let cancelAction = alertController?.actions.first as? AlertActionMock
                    cancelAction?.handler?(cancelAction!)
                }
                it("THEN it should dismiss the alertPopup") {
                    expect(self.calculatorViewControllerMock?.didDismissAlertViewController).toEventually(beTrue())
                }
                it("AND it should display the last calculation 42") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("42"))
                }
            }
            context("WHEN I click on the OK alertPopup button") {
                beforeEach {
                    let alertController = self.calculatorViewControllerMock?.presentedViewController as? UIAlertController
                    let okAction = alertController?.actions.last as? AlertActionMock
                    okAction?.handler?(okAction!)
                }
                it("AND it should reset the last calculation to 0") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("0"))
                }
            }
        }
        describe("GIVEN that I tap 19 times the number 1") {
            beforeEach {
                self.calculatorViewControllerMock = CalculatorViewControllerMock.fromStoryboard(named: "CalculatorMock")
                UIApplication.shared.keyWindow?.rootViewController = self.calculatorViewControllerMock
                let numberOneButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 1 })?.first
                for _ in 0...18 {
                    numberOneButton?.sendActions(for: .touchUpInside)
                }
            }
            context("WHEN I tap another time the number one") {
                beforeEach {
                    let numberOneButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 1 })?.first
                    numberOneButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should display only 19 times the number 1") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("1111111111111111111"))
                    expect(self.calculatorViewControllerMock?.promptLabel?.text?.count).toEventually(equal(19))
                }
            }
        }
        describe("GIVEN that I calculate two very high numbers that gives me an overflowing result") {
            beforeEach {
                self.calculatorViewControllerMock = CalculatorViewControllerMock.fromStoryboard(named: "CalculatorMock")
                UIApplication.shared.keyWindow?.rootViewController = self.calculatorViewControllerMock
                let numberNineButton = (self.calculatorViewControllerMock?.calculatorNumbersButtons?.filter { $0.tag == 9 })?.first
                for _ in 0...22 {
                    numberNineButton?.sendActions(for: .touchUpInside)
                }
                self.calculatorViewControllerMock?.additionButton?.sendActions(for: .touchUpInside)
                for _ in 0...22 {
                    numberNineButton?.sendActions(for: .touchUpInside)
                }
            }
            context("WHEN I click on equals until the limit of the number result") {
                beforeEach {
                    for _ in 0...8 {
                        self.calculatorViewControllerMock?.equalButton?.sendActions(for: .touchUpInside)
                    }
                }
                it("THEN it should display the overflowing number 1e48") {
                    expect(self.calculatorViewControllerMock?.promptLabel?.text).toEventually(equal("1e48"))
                }
            }
        }
    }
}
