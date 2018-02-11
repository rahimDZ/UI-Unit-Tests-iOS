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
