//
//  HumorFacesInteractorMock.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 05/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

@testable import UIUnitTestsIOS

final class HumorFacesInteractorMock
{
    private var networkState: NetworkState
    private var humorFaceType: HumorFaceType
    weak var output: HumorFacesInteractorOutput? = nil

    init(networkState: NetworkState, humorFaceType: HumorFaceType) {
        self.networkState = networkState
        self.humorFaceType = humorFaceType
    }
    
    private func mockResults(for type: HumorFaceType) {
        switch networkState {
        case .success:
            switch type {
            case .happy:
                output?.updateHappyHumorDescription("Happy Description")
                output?.updateHappyImage()
                output?.updateHappyBackgroundColor()
            case .sad:
                output?.updateSadHumorDescription("Sad Description")
                output?.updateSadImage()
                output?.updateSadBackgroundColor()
            case .angry:
                output?.updateAngryHumorDescription("Angry Description")
                output?.updateAngryImage()
                output?.updateAngryBackgroundColor()
            case .surprised:
                output?.updateSurprisedHumordDescription("Surprised Description")
                output?.updateSurprisedImage()
                output?.updateSurprisedBackgroundColor()
            default:
                output?.showNoHumorFound()
            }
        case .successWithNoData:
            output?.showPlaceholder()
        case .networkError: output?.showNetworkError()
        case .serverError: output?.showServerError()
        }
    }
}

// MARK: - Interactor Input

extension HumorFacesInteractorMock: HumorFacesInteractorInput
{
    func findCuriousFace() {
        mockResults(for: .curious)
    }
    
    func findHumorFace() {
        output?.showPlaceholder()
        mockResults(for: humorFaceType)
    }
    
    func refreshHumorFace() {
        output?.showPlaceholder()
        mockResults(for: .surprised)
    }
    
    func findHappyFace() {
        mockResults(for: .happy)
    }
    
    func findSadFace() {
        mockResults(for: .sad)
    }
    
    func findAngryFace() {
        mockResults(for: .angry)
    }
    
    func findSurprisedFace() {
        mockResults(for: .surprised)
    }
}
