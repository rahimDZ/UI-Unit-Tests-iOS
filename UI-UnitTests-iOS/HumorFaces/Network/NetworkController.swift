//
//  NetworkController.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

final class NetworkController
{
    private func sendError(_ error: NetworkControllerError, on completion: @escaping (Error) -> Void) {
        DispatchQueue.main.async {
            completion(error)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    private func getHumorFace(from humorFaceType: HumorFaceType, completion: @escaping (HumorFace) -> Void, errorCompletion: @escaping (Error) -> Void) {
        let serviceUrl = "https://swift-34.000webhostapp.com/?humor=\(humorFaceType.description)"
        guard let url = URL(string: serviceUrl) else { return errorCompletion(NetworkControllerError.invalideUrl) }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let res = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                if (error as NSError).code == URLError.Code.notConnectedToInternet.rawValue {
                    return self.sendError(NetworkControllerError.networkUnreachable, on: errorCompletion)
                }
                return self.sendError(NetworkControllerError.internalServer, on: errorCompletion)
            }
            guard let data = data else {
                return self.sendError(NetworkControllerError.noData, on: errorCompletion)
            }
            do {
                let humorFace = try JSONDecoder().decode(HumorFace.self, from: data)
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completion(humorFace)
                }
            } catch {
                self.sendError(NetworkControllerError.canNotDecode, on: errorCompletion)
            }
        }
        res.resume()
    }
    
    // MARK: - Enum
    
    enum NetworkControllerError: Error
    {
        case invalideUrl
        case networkUnreachable
        case internalServer
        case canNotDecode
        case noData
    }
    
}

// MARK: - NetworkController Input

extension NetworkController: NetworkControllerInput
{
    func findHumorFace(completion: @escaping (HumorFace?, Error?) -> Void) {
        let randomHumorFaceType = Array(HumorFaceType.cases()).randomItem()
        getHumorFace(from: randomHumorFaceType == .error ? .happy : randomHumorFaceType, completion: { humorFace in completion(humorFace, nil) })
        { error in completion(nil, error) }
    }
    
    func findHappyFace(completion: @escaping (HumorFace?, Error?) -> Void) {
        getHumorFace(from: .happy, completion: { humorFace in completion(humorFace, nil) })
        { error in completion(nil, error) }
    }
    
    func findSadFace(completion: @escaping (HumorFace?, Error?) -> Void) {
        getHumorFace(from: .sad, completion: { humorFace in completion(humorFace, nil) })
        { error in completion(nil, error) }
    }
    
    func findAngryFace(completion: @escaping (HumorFace?, Error?) -> Void) {
        getHumorFace(from: .angry, completion: { humorFace in completion(humorFace, nil) })
        { error in completion(nil, error) }
    }
    
    func findSurprisedFace(completion: @escaping (HumorFace?, Error?) -> Void) {
        getHumorFace(from: .surprised, completion: { humorFace in completion(humorFace, nil) })
        { error in completion(nil, error) }
    }

    func findCuriousFace(completion: @escaping (HumorFace?, Error?) -> Void) {
        getHumorFace(from: .curious, completion: { humorFace in completion(humorFace, nil) })
        { error in completion(nil, error) }
    }
}

