//
//  HumorFace.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import Foundation

enum HumorFaceType: Int, EnumCollection
{
    case error = -1
    case happy
    case sad
    case angry
    case surprised
    case curious
    
    var description: String {
        switch self {
        case .happy:
            return "happy"
        case .sad:
            return "sad"
        case .angry:
            return "angry"
        case .surprised:
            return "surprised"
        case .curious:
            return "curious"
        default:
            return "error"
        }
    }
}

struct HumorFace: Decodable
{
    var id: Int
    var type: String
    var description: String
}
