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
    
    @IBOutlet fileprivate(set) weak var signInButton: UIButton?
    @IBOutlet fileprivate(set) weak var signUpButton: UIButton?
    @IBOutlet fileprivate(set) weak var signInSignUpStackView: UIStackView?
    @IBOutlet fileprivate(set) weak var signInSignUpHorizontalCenterConstraint: NSLayoutConstraint?
    @IBOutlet fileprivate(set) weak var signInSignUpVerticalCenterConstraint: NSLayoutConstraint?

    // MARK: - Actions
    
    @IBAction func signUpDidTouchUpInside(_ sender: UIButton) {
        let signUpStoryboard = UIStoryboard(name: "SignUp", bundle: Bundle(for: DashboardViewController.self))
        self.navigationController?.pushViewController(signUpStoryboard.instantiateViewController(withIdentifier: "SignUpViewController"), animated: true)
    }
}
