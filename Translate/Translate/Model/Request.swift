//
//  Request.swift
//  Translate
//
//  Created by 박경춘 on 2023/03/31.
//

import Foundation

struct Request: Codable {
    let source: String
    let target: String
    let text: String
}
