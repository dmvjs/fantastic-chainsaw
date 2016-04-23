//
//  NotRegex.swift
//  NotRegex
//
//  Created by Kirk Elliott on 4/23/16.
//  Copyright © 2016 dmvjs. All rights reserved.
//

import Foundation

public struct NotRegex {
    let indexes: [Int]
    let string: String
    let parts: [String]?
}

extension NotRegex {
    
    func replaceWith (replaceWith: String) -> String {
        if let parts = self.parts {
            return parts.joinWithSeparator(replaceWith)
        }
        return self.string
    }
    
    func replaceWith (replaceWith: Character) -> String {
        var chars = Array(self.string.characters)
        for index in self.indexes {
            chars[index] = replaceWith
        }
        return String(chars)
    }
    
    func find (string: String) -> NotRegex? {
        return self.string.find(string)
    }
    
    func find (characters: [Character]) -> NotRegex? {
        return self.string.find(characters)
    }
    
    func find (character: Character) -> NotRegex? {
        return self.string.find(character)
    }
}
