//
//  DashboardViewController.swift
//  UI-UnitTests-iOS
//
//  Created by Abderrahim BENMAKHLOUF on 21/01/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

open class DashboardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate(set) weak var welcomeTitleLabel: UILabel?
    @IBOutlet fileprivate(set) weak var welcomeTitleTopConstraint: NSLayoutConstraint?
    @IBOutlet fileprivate(set) weak var welcomeTitleHorizontalCenterConstraints: NSLayoutConstraint?
    
    @IBOutlet fileprivate(set) weak var aboutButton: UIButton?
    @IBOutlet fileprivate(set) weak var calculatorButton: UIButton?
    @IBOutlet fileprivate(set) weak var aboutStackView: UIStackView?
    @IBOutlet fileprivate(set) weak var aboutHorizontalCenterConstraint: NSLayoutConstraint?
    @IBOutlet fileprivate(set) weak var aboutVerticalCenterConstraint: NSLayoutConstraint?

    // MARK: - Actions
    
    @IBAction func aboutDidTouchUpInside(_ sender: UIButton) {
        let aboutStoryboard = UIStoryboard(name: "About", bundle: Bundle(for: DashboardViewController.self))
        self.navigationController?.pushViewController(aboutStoryboard.instantiateViewController(withIdentifier: "AboutViewController"), animated: true)
    }
}
