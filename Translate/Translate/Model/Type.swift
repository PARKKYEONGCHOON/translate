//
//  Type.swift
//  Translate
//
//  Created by 박경춘 on 2023/03/31.
//

import UIKit

enum `Type` {
    case source
    case target
    
    var color: UIColor {
        switch self {
        case .source: return .label
        case .target: return .tintColor
        }
    }
}
