//
//  ModuleFactory.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 22/02/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

protocol ModuleFactoryInput: class
{
    func initCalculatorPresenter() -> CalculatorPresenterInput?
    func initHumorFacesPresenter() -> HumorFacesPresenterInput?
}

extension ModuleFactoryInput
{
    func initCalculatorPresenter() -> CalculatorPresenterInput? { return nil }
    func initHumorFacesPresenter() -> HumorFacesPresenterInput? { return nil }
}

extension CalculatorViewController: ModuleFactoryInput { }

extension HumorFacesViewController: ModuleFactoryInput { }
