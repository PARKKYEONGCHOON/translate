//
//  BookMark.swift
//  Translate
//
//  Created by 박경춘 on 2023/03/31.
//

import Foundation

struct BookMark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language
    
    let sourceText: String
    let translatedText: String
}


