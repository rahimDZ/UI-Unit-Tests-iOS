//
//  HumorFacesViewController.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

class HumorFacesViewController: UIViewController
{
    // MARK: - Property
    
    lazy var presenter: HumorFacesPresenterInput? = {
        return initHumorFacesPresenter()
    }()
    
    var customAlertAction: CustomAlertActionInput {
        return CustomAlertAction()
    }

    // MARK: - Outlets
    
    @IBOutlet private(set) weak var humorDescriptionLabel: UILabel?
    
    @IBOutlet private(set) weak var humorFaceImageView: UIImageView?
    @IBOutlet private(set) weak var happyFaceButton: UIButton?
    @IBOutlet private(set) weak var sadFaceButton: UIButton?
    @IBOutlet private(set) weak var angryFaceButton: UIButton?
    @IBOutlet private(set) weak var surprisedFaceButton: UIButton?
    @IBOutlet private(set) weak var curiousFaceButton: UIButton?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Humor Faces"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh(sender:)))
        presenter?.viewDidLoad()
    }
    
    // MARK: - ModuleFactory Input
    
    func initHumorFacesPresenter() -> HumorFacesPresenterInput? {
        let networkController = NetworkController()
        let interactor = HumorFacesInteractor(networkController: networkController)
        let presenter = HumorFacesPresenter(interactor: interactor)
        interactor.output = presenter
        presenter.view = self
        return presenter
    }
    
    // MARK: - Button Actions
    
    @objc func refresh(sender: UIBarButtonItem) {
        presenter?.refreshDidTouchUpInside()
    }
    
    @IBAction func happyFaceButtonDidTouchUpInside(_ sender: UIButton) {
        presenter?.happyFaceButtonDidTouchUpInside()
    }

    @IBAction func sadFaceButtonDidTouchUpInside(_ sender: UIButton) {
        presenter?.sadFaceButtonDidTouchUpInside()
    }

    @IBAction func angryFaceButtonDidTouchUpInside(_ sender: UIButton) {
        presenter?.angryFaceButtonDidTouchUpInside()
    }

    @IBAction func surprisedFaceButtonDidTouchUpInside(_ sender: UIButton) {
        presenter?.surprisedFaceButtonDidTouchUpInside()
    }

    @IBAction func curiousFaceButtonDidTouchUpInside(_ sender: UIButton) {
        presenter?.curiousFaceButtonDidTouchUpInside()
    }

    func dismissAlertViewController() { }
    
    func displayPopupAlert(title: String, message: String, cancelTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = customAlertAction.actionWithTitle(cancelTitle, style: .default) { _ -> Void in
            self.dismissAlertViewController()
        }
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Presenter Output

extension HumorFacesViewController: HumorFacesPresenterOutput
{
    func displayHumorDescription(_ description: String) {
        humorDescriptionLabel?.text = description
    }
    
    func updateHumorImage(named: String) {
        humorFaceImageView?.image = UIImage(named: named)
    }
    
    func updateBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    
    func showAlertViewErrorWithTitle(_ title: String, message: String, cancelTitle: String) {
        displayPopupAlert(title: title, message: message, cancelTitle: cancelTitle)
    }
}
