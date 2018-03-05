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

@testable import UIUnitTestsIOS

final class DashboardUIBehaviorsTests: QuickSpec {
    
    public var dashboardViewControllerMock: DashboardViewControllerMock?
    public var navigationController: UINavigationController?
    
    override func spec() {
        describe("When I access Dashboard Page") {
            beforeEach {
                self.dashboardViewControllerMock = DashboardViewControllerMock.fromStoryboard(named: "DashboardMock")
                self.dashboardViewControllerMock?.view.layoutSubviews()
                self.navigationController = UINavigationController(rootViewController: self.dashboardViewControllerMock!)
            }
            // from segue on storyboard
            context("And the user clicks on the Calculator Button") {
                beforeEach {
                    self.dashboardViewControllerMock?.calculatorButton?.sendActions(for: .touchUpInside)
                }
                it("should display Calculator page") {
                    expect(self.dashboardViewControllerMock?.didDisplaysLoginViewController).toEventually(beTrue())
                    expect(self.dashboardViewControllerMock?.destinationViewController).toNotEventually(beNil())
                }
                it("should display Calculator page with modal presentation") {
                    expect(self.dashboardViewControllerMock?.destinationViewController?.modalPresentationStyle).toEventually(equal(UIModalPresentationStyle.fullScreen))
                }
                it("should diplay Calculator page with cross disolve transition style") {
                    expect(self.dashboardViewControllerMock?.destinationViewController?.modalTransitionStyle).toEventually(equal(UIModalTransitionStyle.crossDissolve))
                }
            }
            context("And the user clicks on the Humor Faces Button") {
                beforeEach {
                    self.dashboardViewControllerMock?.humorFacesButton?.sendActions(for: .touchUpInside)
                }
                it("should display Humor Faces page") {
                    expect(self.dashboardViewControllerMock?.didDisplaysHumorFacesViewController).toEventually(beTrue())
                    expect(self.dashboardViewControllerMock?.destinationViewController).toNotEventually(beNil())
                    expect((self.navigationController?.viewControllers.contains(where: { return $0 is HumorFacesViewController }))).toEventually(beTrue())
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
