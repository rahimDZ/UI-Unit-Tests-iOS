//
//  DashboardViewControllerMock.swift
//  UI-UnitTests-iOSTests
//
//  Created by Abderrahim BENMAKHLOUF on 21/01/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import XCTest
import Quick
import Nimble
import UIKit

@testable import UI_UnitTests_iOS

class DashboardViewControllerMock: DashboardViewController {
    
    public var didDisplaysLoginViewController: Bool = false
    public var calculatorViewController: UIViewController? = nil

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "CalculatorSegueIdentifier" {
            didDisplaysLoginViewController = true
            calculatorViewController = segue.destination
        }
    }
}


final class DashboardUITests: QuickSpec {
    
    public var dashboardViewControllerMock: DashboardViewControllerMock?
    
    override func spec() {
        describe("UI Elements Tests") {
            context("All UI Elements are valid") {
                beforeEach {
                    self.dashboardViewControllerMock = DashboardViewControllerMock.fromStoryboard(named: "DashboardMock")
                    
                    // To be able to retrieve custom fonts
                    let fileManager = FileManager.default
                    let bundleURL = Bundle(for: DashboardViewControllerMock.self).bundleURL
                    do {
                        let contents = try fileManager.contentsOfDirectory(at: bundleURL, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
                        for url in contents {
                            if  ["ttf","otf"].contains(url.pathExtension) {
                                let fontData = NSData(contentsOf: url)
                                let provider = CGDataProvider(data: fontData!)
                                let font = CGFont(provider!)
                                CTFontManagerRegisterGraphicsFont(font!, nil)
                            }
                        }
                    } catch {
                        print("error: \(error)")
                    }
                }
                context("the title") {
                    it("should have valid constraints") {
                        expect(self.dashboardViewControllerMock?.welcomeTitleLabel?.text).toEventually(equal("UI-UnitTests-iOS"))
                        expect(self.dashboardViewControllerMock?.welcomeTitleTopConstraint?.constant).toEventually(equal(50.0))
                        expect(self.dashboardViewControllerMock?.welcomeTitleHorizontalCenterConstraints?.constant).toEventually(equal(0.0))
                    }
                    
                    it("should have valid font and size") {
                        expect(self.dashboardViewControllerMock?.welcomeTitleLabel?.font.fontName).toEventually(equal("TimesNewRomanPS-BoldMT"))
                        expect(self.dashboardViewControllerMock?.welcomeTitleLabel?.font.pointSize).toEventually(equal(20.0))

                    }
                }
                context("the Sign In / Sign Up stackView") {
                    it("should have valid constraints") {
                        expect(self.dashboardViewControllerMock?.aboutHorizontalCenterConstraint?.constant).toEventually(equal(0.0))
                        expect(self.dashboardViewControllerMock?.aboutVerticalCenterConstraint?.constant).toEventually(equal(0.0))
                    }
                    it("should have valid spacings") {
                        expect(self.dashboardViewControllerMock?.aboutStackView?.spacing).toEventually(equal(100.0))
                    }
                }
            }
        }
    }
}

extension UIViewController
{
    class func fromStoryboard<T: UIViewController>(named storyboardName: String) -> T? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: T.self))
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T
        vc?.view.layoutSubviews()
        return vc
    }
}


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
