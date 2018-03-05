//
//  HumorFacesInteractorBoundaries.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

protocol HumorFacesInteractorInput: class
{
    func findHumorFace()
    func refreshHumorFace()
    func findHappyFace()
    func findSadFace()
    func findAngryFace()
    func findSurprisedFace()
    func findCuriousFace()
}

protocol HumorFacesInteractorOutput: class
{
    func showPlaceholder()
    
    func updateHappyHumorDescription(_ description: String)
    func updateSadHumorDescription(_ description: String)
    func updateAngryHumorDescription(_ description: String)
    func updateSurprisedHumordDescription(_ description: String)

    func updateHappyImage()
    func updateSadImage()
    func updateAngryImage()
    func updateSurprisedImage()

    func updateHappyBackgroundColor()
    func updateSadBackgroundColor()
    func updateAngryBackgroundColor()
    func updateSurprisedBackgroundColor()
    
    func showServerError()
    func showNetworkError()
    
    func showNoHumorFound()
}
