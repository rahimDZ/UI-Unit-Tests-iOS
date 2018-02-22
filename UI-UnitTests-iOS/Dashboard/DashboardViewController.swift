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
    @IBOutlet private(set) weak var aboutStackView: UIStackView?
    @IBOutlet private(set) weak var aboutHorizontalCenterConstraint: NSLayoutConstraint?
    @IBOutlet private(set) weak var aboutVerticalCenterConstraint: NSLayoutConstraint?

    // MARK: - Actions
    
    @IBAction func aboutDidTouchUpInside(_ sender: UIButton) {
        let aboutStoryboard = UIStoryboard(name: "About", bundle: Bundle(for: DashboardViewController.self))
        self.navigationController?.pushViewController(aboutStoryboard.instantiateViewController(withIdentifier: "AboutViewController"), animated: true)
    }
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "CalculatorSegueIdentifier", let destinationVC = segue.destination as? CalculatorViewController {
            let interactor = CalculatorInteractor()
            let presenter = CalculatorPresenter(interactor: interactor)
            interactor.output = presenter
            presenter.view = destinationVC
            destinationVC.presenter = presenter
        }
    }
}
