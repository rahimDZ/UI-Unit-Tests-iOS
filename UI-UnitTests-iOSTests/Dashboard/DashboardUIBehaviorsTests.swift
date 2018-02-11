//
//  DashboardUIBehaviorsTests.swift
//  UI-UnitTests-iOSTests
//
//  Created by Abderrahim BENMAKHLOUF on 11/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import XCTest
import Quick
import Nimble
import UIKit

@testable import UI_UnitTests_iOS

final class DashboardUIBehaviorsTests: QuickSpec {
    
    public var dashboardViewControllerMock: DashboardViewControllerMock?
    public var navigationController: UINavigationController?
    
    override func spec() {
        describe("When I access Dashboard Page") {
            beforeEach {
                self.dashboardViewControllerMock = DashboardViewControllerMock.fromStoryboard(named: "DashboardMock")
                self.navigationController = UINavigationController(rootViewController: self.dashboardViewControllerMock!)
            }
            // from segue on storyboard
            context("And the user clicks on the Calculator Button") {
                beforeEach {
                    self.dashboardViewControllerMock?.calculatorButton?.sendActions(for: .touchUpInside)
                }
                it("should display Calculator page") {
                    expect(self.dashboardViewControllerMock?.didDisplaysLoginViewController).toEventually(beTrue())
                    expect(self.dashboardViewControllerMock?.calculatorViewController).toNotEventually(beNil())
                }
                it("should display Calculator page with modal presentation") {
                    expect(self.dashboardViewControllerMock?.calculatorViewController?.modalPresentationStyle).toEventually(equal(UIModalPresentationStyle.fullScreen))
                }
                it("should diplay Calculator page with cross disolve transition style") {
                    expect(self.dashboardViewControllerMock?.calculatorViewController?.modalTransitionStyle).toEventually(equal(UIModalTransitionStyle.crossDissolve))
                }
            }
            // from button action programatically
            context("And the user clicks on the About Button") {
                beforeEach {
                    self.dashboardViewControllerMock?.aboutButton?.sendActions(for: .touchUpInside)
                }
                it("should display Calculator page") {
                    expect((self.navigationController?.viewControllers.contains(where: { return $0 is AboutViewController }))).toEventually(beTrue())
                }
            }
        }
    }
}
