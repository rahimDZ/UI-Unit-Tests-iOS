//
//  NetworkControllerBoundaries.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

protocol NetworkControllerInput: class
{
    func findHumorFace(completion: @escaping (_ response: HumorFace?, _ error: Error?) -> Void)
    func findHappyFace(completion: @escaping (_ response: HumorFace?, _ error: Error?) -> Void)
    func findSadFace(completion: @escaping (_ response: HumorFace?, _ error: Error?) -> Void)
    func findAngryFace(completion: @escaping (_ response: HumorFace?, _ error: Error?) -> Void)
    func findSurprisedFace(completion: @escaping (_ response: HumorFace?, _ error: Error?) -> Void)
    func findCuriousFace(completion: @escaping (HumorFace?, Error?) -> Void)
}
