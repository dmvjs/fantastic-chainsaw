import Foundation

// demo at the bottom ⬇️⬇️⬇️

extension String {
    
    // search for consecutive characters as cohesive string
    func chars (string: String) -> [Int]? {
        var ints:[Int] = []
        let array = self.componentsSeparatedByString(string)
        var pointer = 0
        for item in array {
            ints.append(item.characters.count + pointer)
            pointer += item.characters.count + string.characters.count
        }
        let arr = Array(ints[0..<ints.count - 1])
        return arr.count > 0 ? arr : nil
    }
    
    // search for discrete characters
    func chars (characters: [Character]) -> [Int]? {
        var ints:[[Int]] = []
        var charsThusFar:[Character] = []
        for char in characters {
            if !charsThusFar.contains(char) {
                charsThusFar.append(char)
                if let charInts = chars(char) {
                    ints.append(charInts)
                }
            }
        }
        return ints.count > 0 ? ints.flatMap {$0}.sort() : nil
    }
    
    // search for individual characters
    func chars (character: Character) -> [Int]? {
        var ints:[Int] = []
        for (index, element) in self.characters.enumerate() {
            if element == character {
                ints.append(index)
            }
        }
        return ints.count > 0 ? ints : nil
    }
    
    // helper utility
    func indexOf(string: String) -> String.Index {
        return rangeOfString(string, options: .LiteralSearch, range: nil, locale: nil)?.startIndex ?? startIndex
    }
}
"🍣sashimi!!!🍣".chars("🍣")
"this is a sample".chars(" ")
"this is a sample".chars("is")
"this is a sample".chars(Array("is".characters))
"nofuckingmatch".chars(" ")


