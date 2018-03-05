//
//  HumorFacesPresenter.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

class HumorFacesPresenter
{
    // MARK: - Property
    
    weak var view: HumorFacesPresenterOutput? = nil
    var interactor: HumorFacesInteractorInput
    
    // MARK: - Lifecycle
    
    init(interactor: HumorFacesInteractorInput) {
        self.interactor = interactor
    }
    
    // MARK: - Enum
    
    private enum Constants
    {
        
    }
}

// MARK: - Presenter Input

extension HumorFacesPresenter: HumorFacesPresenterInput
{
    func viewDidLoad() {
        interactor.findHumorFace()
    }
    
    func refreshDidTouchUpInside() {
        interactor.refreshHumorFace()
    }
    
    func happyFaceButtonDidTouchUpInside() {
        interactor.findHappyFace()
    }
    
    func sadFaceButtonDidTouchUpInside() {
        interactor.findSadFace()
    }
    
    func angryFaceButtonDidTouchUpInside() {
        interactor.findAngryFace()
    }
    
    func surprisedFaceButtonDidTouchUpInside() {
        interactor.findSurprisedFace()
    }
    
    func curiousFaceButtonDidTouchUpInside() {
        interactor.findCuriousFace()
    }
}

// MARK: - Interactor Output

extension HumorFacesPresenter: HumorFacesInteractorOutput
{
    func showPlaceholder() {
        view?.displayHumorDescription("-")
        view?.updateBackgroundColor(.white)
        view?.updateHumorImage(named: "placeholder")
    }
    
    func updateHappyHumorDescription(_ description: String) {
        view?.displayHumorDescription(description)
    }
    
    func updateSadHumorDescription(_ description: String) {
        view?.displayHumorDescription(description)
    }
    
    func updateAngryHumorDescription(_ description: String) {
        view?.displayHumorDescription(description)
    }
    
    func updateSurprisedHumordDescription(_ description: String) {
        view?.displayHumorDescription(description)
    }
    
    func updateHappyImage() {
        view?.updateHumorImage(named: "happy")
    }
    
    func updateSadImage() {
        view?.updateHumorImage(named: "sad")
    }
    
    func updateAngryImage() {
        view?.updateHumorImage(named: "angry")
    }
    
    func updateSurprisedImage() {
        view?.updateHumorImage(named: "surprised")
    }
    
    func updateHappyBackgroundColor() {
        view?.updateBackgroundColor(.happyFace)
    }
    
    func updateSadBackgroundColor() {
        view?.updateBackgroundColor(.sadFace)
    }
    
    func updateAngryBackgroundColor() {
        view?.updateBackgroundColor(.angryFace)
    }
    
    func updateSurprisedBackgroundColor() {
        view?.updateBackgroundColor(.surprisedFace)
    }
    
    func showServerError() {
        view?.showAlertViewErrorWithTitle("Oops! Something went wrong!", message: "The application has encountered an unknown error.", cancelTitle: "OK")
    }
    
    func showNetworkError() {
        view?.showAlertViewErrorWithTitle("Network Problem", message: "It seems that you have no Internet connection.", cancelTitle: "OK")
    }
    
    func showNoHumorFound() {
        view?.displayHumorDescription("No Humor Found")
        view?.updateBackgroundColor(.orange)
        view?.updateHumorImage(named: "error_face")
    }
}
