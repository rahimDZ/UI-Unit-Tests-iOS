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
    
    @IBOutlet private(set) weak var welcomeTitleLabel: UILabel?
    @IBOutlet private(set) weak var welcomeTitleTopConstraint: NSLayoutConstraint?
    @IBOutlet private(set) weak var welcomeTitleHorizontalCenterConstraints: NSLayoutConstraint?
    
    @IBOutlet private(set) weak var aboutButton: UIButton?
    @IBOutlet private(set) weak var calculatorButton: UIButton?
    @IBOutlet private(set) weak var humorFacesButton: UIButton?
    @IBOutlet private(set) weak var stackView: UIStackView?
    @IBOutlet private(set) weak var stackViewHorizontalCenterConstraint: NSLayoutConstraint?
    @IBOutlet private(set) weak var stackViewVerticalCenterConstraint: NSLayoutConstraint?

    // MARK: - Actions
    
    @IBAction func aboutDidTouchUpInside(_ sender: UIButton) {
        let aboutStoryboard = UIStoryboard(name: "About", bundle: Bundle(for: DashboardViewController.self))
        self.navigationController?.pushViewController(aboutStoryboard.instantiateViewController(withIdentifier: "AboutViewController"), animated: true)
    }
}
