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
    func initPresenter() -> CalculatorPresenterInput
}

extension CalculatorViewController: ModuleFactoryInput { }
