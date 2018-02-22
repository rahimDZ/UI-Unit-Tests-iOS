//
//  CalculatorViewController.swift
//  UI-UnitTests-iOS
//
//  Created by Abderrahim BENMAKHLOUF on 21/01/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController
{    
    // MARK: - Outlets

    @IBOutlet private(set) weak var promptLabel: UILabel?
    
    @IBOutlet private(set) var calculatorNumbersButtons: [CustomButton]?
    
    @IBOutlet private(set) weak var cancelButton: CustomButton?
    
    @IBOutlet private(set) weak var additionButton: CustomButton?
    
    @IBOutlet private(set) weak var equalButton: CustomButton?
    
    @IBOutlet private(set) weak var closeButton: UIBarButtonItem?
    
    // MARK: - Property
    
    lazy var presenter: CalculatorPresenterInput? = {
        return initPresenter()
    }()
    
    var customAlertAction: CustomAlertActionInput {
        return CustomAlertAction()
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    
    @IBAction func dismissDidTouchUpInside(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func numbersDidTouchUpInside(_ sender: CustomButton) {
        print("user did touch : \(sender.tag)")
        presenter?.userDidSelectNumber(sender.tag)
    }
    
    @IBAction func additionButtonDidTouchUpInside(_ sender: CustomButton) {
        print("user did click on addition")
        presenter?.additionButtonDidTouchUpInside()
    }
    
    @IBAction func resetButtonDidTouchUpInside(_ sender: CustomButton) {
        print("user did click on reset")
        presenter?.resetButtonDidTouchUpInside()
    }
    
    @IBAction func equalButtonDidTouchUpInside(_ sender: CustomButton) {
        print("user did click on equal")
        presenter?.equalButtonDidTouchUpInside()
    }
    
    // MARK: - Others
    
    func displayResult(_ result: String) {
        self.promptLabel?.text = result
    }
    
    func confirmReset() {
        presenter?.confirmResetDidSelectedOnPopup()
    }
    
    func dismissAlertViewController() { }
    
    func displayPopupAlert(title: String, message: String, confirmationTitle: String, cancelTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let confirmationAction = customAlertAction.actionWithTitle(cancelTitle, style: .default) { _ -> Void in
            self.confirmReset()
        }

        let cancelAction = customAlertAction.actionWithTitle(cancelTitle, style: .destructive) { _ -> Void in
            self.dismissAlertViewController()
        }

        alertController.addAction(cancelAction)
        alertController.addAction(confirmationAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func initPresenter() -> CalculatorPresenterInput {
        let interactor = CalculatorInteractor()
        let presenter = CalculatorPresenter(interactor: interactor)
        interactor.output = presenter
        presenter.view = self
        return presenter
    }
}

// MARK: - Presenter Output

extension CalculatorViewController: CalculatorPresenterOutput
{
    func display(_ result: String) {
        displayResult(result)
    }
    
    func displayConfirmationResetPopupAlert(title: String, message: String, confirmationTitle: String, cancelTitle: String) {
        displayPopupAlert(title: title, message: message, confirmationTitle: confirmationTitle, cancelTitle: cancelTitle)
    }
}
