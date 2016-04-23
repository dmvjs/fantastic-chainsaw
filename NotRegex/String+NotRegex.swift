//
//  String+NotRegex.swift
//  NotRegex
//
//  Created by Kirk Elliott on 4/23/16.
//  Copyright © 2016 dmvjs. All rights reserved.
//

import Foundation

extension String {
    
    // search for consecutive characters as cohesive string
    func find (string: String) -> NotRegex? {
        var ints:[Int] = []
        let array = self.componentsSeparatedByString(string)
        var pointer = 0
        for item in array {
            ints.append(item.characters.count + pointer)
            pointer += item.characters.count + string.characters.count
        }
        let arr = Array(ints[0..<ints.count - 1])
        return arr.count > 0 ? NotRegex(indexes: arr, string: self, parts: array) : nil
    }
    
    // search for discrete characters individually
    func find (characters: [Character]) -> NotRegex? {
        var ints:[[Int]] = []
        var charsThusFar:[Character] = []
        for char in characters {
            if !charsThusFar.contains(char) {
                charsThusFar.append(char)
                if let charInts = find(char) {
                    ints.append(charInts.indexes)
                }
            }
        }
        return ints.count > 0 ? NotRegex(indexes: ints.flatMap {$0}.sort(), string: self, parts: nil) : nil
    }
    
    // search for individual characters
    func find (character: Character) -> NotRegex? {
        var ints:[Int] = []
        for (index, element) in self.characters.enumerate() {
            if element == character {
                ints.append(index)
            }
        }
        return ints.count > 0 ? NotRegex(indexes: ints, string: self, parts: nil) : nil
    }
    
    // find the first index int for the range provided
    // NOT optimized!!!
    func findFirstWithRange(rangeString: String) -> Int? {
        if let ints = self.findWithRange(rangeString), let first = ints.first {
            return first
        }
        return nil
    }
    
    // find array of index int for the range provided
    func findWithRange(rangeString: String) -> [Int]? {
        if let rangedChars = getArrayOfCharsFromFirstToLast(rangeString) {
            var ints:[Int] = []
            for (index, char) in self.characters.enumerate() {
                for c in rangedChars {
                    if char == c {
                        ints.append(index)
                    }
                }
            }
            return ints.count > 0 ? ints : nil
        }
        return nil
    }
    
    /**
     get an array of Character for a range string where:
     1. there are always 2 characters in the rangeString (no separator)
     2. works even if entered incorrectly (first > last || first == last)
     */
    func getArrayOfCharsFromFirstToLast (rangeString: String) -> [Character]? {
        guard rangeString.characters.count == 2 else {
            return nil
        }
        guard rangeString.characters.first != rangeString.characters.last else {
            if let first = rangeString.characters.first {
                return [first]
            }
            return nil
        }
        let firstScalar = rangeString.substringToIndex(rangeString.startIndex.successor()).unicodeScalars
        let lastScalar = rangeString.substringFromIndex(rangeString.startIndex.successor()).unicodeScalars
        let startValue = firstScalar[firstScalar.startIndex].value
        let endValue = lastScalar[lastScalar.startIndex].value
        let distance = max(startValue, endValue) - min(startValue, endValue)
        if distance == 0, let char = rangeString.characters.first {
            return [char]
        }
        let chars: [Character] = (0..<distance).map {
            i in Character(UnicodeScalar(min(startValue, endValue) + i))
        }
        return chars.count > 0 ? chars : nil
    }
    
}
