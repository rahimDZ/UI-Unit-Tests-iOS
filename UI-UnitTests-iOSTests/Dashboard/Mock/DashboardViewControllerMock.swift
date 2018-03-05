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

@testable import UIUnitTestsIOS

class DashboardViewControllerMock: DashboardViewController {
    
    public var didDisplaysLoginViewController: Bool = false
    public var didDisplaysHumorFacesViewController: Bool = false
    public var destinationViewController: UIViewController? = nil

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "CalculatorSegueIdentifier" {
            didDisplaysLoginViewController = true
        } else if segue.identifier == "HumorFacesSegueIdentifier" {
            didDisplaysHumorFacesViewController = true
        }
        destinationViewController = segue.destination
    }
}
