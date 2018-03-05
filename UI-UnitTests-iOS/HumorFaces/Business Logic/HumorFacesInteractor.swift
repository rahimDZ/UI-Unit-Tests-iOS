//
//  HumorFacesInteractor.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

final class HumorFacesInteractor
{
    // MARK: - property

    private var networkController: NetworkControllerInput
    weak var output: HumorFacesInteractorOutput? = nil

    // MARK: - Lifecycle
    
    init(networkController: NetworkControllerInput) {
        self.networkController = networkController
    }
    
    // MARK: - Responses
    
    private func checkResponse(_ response: (humorFace: HumorFace?, error: Error?)) {
        if let error = response.error {
            self.showError(error)
            return
        }
        if let humorFace = response.humorFace {
            if let type = HumorFaceType(rawValue: humorFace.id) {
                switch type {
                case .happy:
                    output?.updateHappyHumorDescription(humorFace.description)
                    output?.updateHappyImage()
                    output?.updateHappyBackgroundColor()
                case .sad:
                    output?.updateSadHumorDescription(humorFace.description)
                    output?.updateSadImage()
                    output?.updateSadBackgroundColor()
                case .angry:
                    output?.updateAngryHumorDescription(humorFace.description)
                    output?.updateAngryImage()
                    output?.updateAngryBackgroundColor()
                case .surprised:
                    output?.updateSurprisedHumordDescription(humorFace.description)
                    output?.updateSurprisedImage()
                    output?.updateSurprisedBackgroundColor()
                default:
                    output?.showNoHumorFound()
                }
            }
        }
    }
    
    private func showError(_ error: Error) {
        if let networkError = error as? NetworkController.NetworkControllerError {
            switch networkError {
            case .networkUnreachable:
                output?.showNetworkError()
            case .noData:
                output?.showPlaceholder()
            default:
                output?.showServerError()
            }
        }
    }
}

// MARK: - Interactor Input

extension HumorFacesInteractor: HumorFacesInteractorInput
{
    func findHumorFace() {
        networkController.findHumorFace { (humorFace, error) in self.checkResponse((humorFace: humorFace, error: error)) }
    }
    
    func refreshHumorFace() {
        findHumorFace()
    }
    
    func findHappyFace() {
        networkController.findHappyFace { (humorFace, error) in self.checkResponse((humorFace: humorFace, error: error)) }
    }
    
    func findSadFace() {
        networkController.findSadFace { (humorFace, error) in self.checkResponse((humorFace: humorFace, error: error)) }
    }
    
    func findAngryFace() {
        networkController.findAngryFace { (humorFace, error) in self.checkResponse((humorFace: humorFace, error: error)) }
    }
    
    func findSurprisedFace() {
        networkController.findSurprisedFace { (humorFace, error) in self.checkResponse((humorFace: humorFace, error: error)) }
    }
    
    func findCuriousFace() {
        networkController.findCuriousFace { (humorFace, error) in self.checkResponse((humorFace: humorFace, error: error)) }
    }
}
