//
//  Response.swift
//  Translate
//
//  Created by 박경춘 on 2023/03/31.
//

import Foundation

struct Response: Decodable {
    
    private let message: Message
    
    var translateText: String { message.result.translatedText }
    
    struct Message: Decodable {
        let result: Result
    }
    
    struct Result: Decodable {
        let translatedText: String
    }
    
    
}
