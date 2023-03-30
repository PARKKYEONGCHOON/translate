//
//  UserDefaults.swift
//  Translate
//
//  Created by 박경춘 on 2023/03/31.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case bookmarks
    }
    
    var bookmarks: [BookMark] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Key.bookmarks.rawValue) else { return []}
            
            return (try? PropertyListDecoder().decode([BookMark].self, from: data)) ?? []
        }
        set {
            
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue), forKey: Key.bookmarks.rawValue)
            
            
        }
    }
}
