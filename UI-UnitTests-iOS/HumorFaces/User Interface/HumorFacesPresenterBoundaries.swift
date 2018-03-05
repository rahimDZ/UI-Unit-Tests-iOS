//
//  HumorFacesPresenterBoundaries.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

protocol HumorFacesPresenterInput: class
{
    func viewDidLoad()
    func refreshDidTouchUpInside()
    func happyFaceButtonDidTouchUpInside()
    func sadFaceButtonDidTouchUpInside()
    func angryFaceButtonDidTouchUpInside()
    func surprisedFaceButtonDidTouchUpInside()
    func curiousFaceButtonDidTouchUpInside()
}

protocol HumorFacesPresenterOutput: class
{
    func displayHumorDescription(_ description: String)
    func updateHumorImage(named: String)
    func updateBackgroundColor(_ color: UIColor)
    func showAlertViewErrorWithTitle(_ title: String, message: String, cancelTitle: String)
}
