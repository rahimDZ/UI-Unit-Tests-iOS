//
//  DashboardUIElementsTests.swift
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

final class DashboardUIElementsTests: QuickSpec {
    
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

